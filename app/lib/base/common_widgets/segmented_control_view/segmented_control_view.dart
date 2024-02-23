import '../../common_widgets/segmented_control_view/segmented_control_item.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'segmented_control_item_view.dart';

@immutable
class SegmentedControlView extends StatefulWidget {
  final List<SegmentedControlItem> items;
  final Color mainBackgroundColor;
  final double size;
  const SegmentedControlView(
      {required this.items,
      this.mainBackgroundColor = AppColors.primaryLight,
      this.size = 50.0,
      super.key});

  @override
  State<SegmentedControlView> createState() => _SegmentedControlViewState();
}

class _SegmentedControlViewState extends State<SegmentedControlView> {
  List<SegmentedControlItem> _items = [];
  Color _mainBackgroundColor = AppColors.primaryLight;

  @override
  void initState() {
    _items = widget.items;
    _mainBackgroundColor = widget.mainBackgroundColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      child: Container(
          decoration: BoxDecoration(
              color: _mainBackgroundColor,
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List<Widget>.generate(_items.length, (int index) {
              return Expanded(
                child: SegmentedControlItemView(
                  item: _items[index],
                  onTapped: (item) {
                    _onItemSelected(index);
                  },
                ),
              );
            }).toList(),
          )),
    );
  }

  _onItemSelected(int index) {
    _items = _items.map((e) {
      e.isSelected = false;
      return e;
    }).toList();
    _items[index].isSelected = true;
    _items[index].onTapped?.call();
    setState(() {});
  }
}
