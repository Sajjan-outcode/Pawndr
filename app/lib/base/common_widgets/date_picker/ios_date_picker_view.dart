import 'package:flutter/cupertino.dart';

import '../bar/accessory_bar.dart';

class IOSDatePickerView extends StatefulWidget {
  final Function(DateTime?)? onDatePicked;
  final CupertinoDatePickerMode mode;
  final DateTime? initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  const IOSDatePickerView(
      {super.key,
      this.onDatePicked,
      required this.mode,
      this.initialDateTime,
      this.minimumDate,
      this.maximumDate});

  @override
  State<IOSDatePickerView> createState() => _IOSDatePickerViewState();
}

class _IOSDatePickerViewState extends State<IOSDatePickerView> {
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          AcessoryBar(
            onCancelPressed: () {
              Navigator.pop(context);
            },
            onDonePressed: () {
              widget.onDatePicked?.call(selectedDateTime);
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
                mode: widget.mode,
                initialDateTime: widget.initialDateTime,
                maximumDate: widget.maximumDate,
                minimumDate: widget.minimumDate,
                onDateTimeChanged: (val) {
                  selectedDateTime = val;
                }),
          ),
        ],
      ),
    );
  }
}
