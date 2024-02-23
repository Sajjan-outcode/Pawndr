import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';
import '../buttons/app_button.dart';
import '../buttons/app_button_state.dart';

class DateRangeSelectionView extends StatelessWidget {
  final List<DateTime> selectedDates;
  final Function(List<DateTime>)? onSelectedDatesChanged;
  DateRangeSelectionView(
      {required this.selectedDates, this.onSelectedDatesChanged, super.key});
  final DateRangePickerController _calendarController =
      DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55),
      child: Container(
          decoration: AppStyles.bottomSheetBoxDecoration(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Select Date",
                  style: AppStyles.boldMedium(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SfDateRangePicker(
                  controller: _calendarController,
                  initialSelectedDates: selectedDates,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange:
                      PickerDateRange(selectedDates.first, selectedDates.last),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        title: "Cancel",
                        appButtonState: AppButtonState.enabled,
                        onClick: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: AppColors.red,
                        textColor: AppColors.white,
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: AppButton(
                        title: "Filter",
                        appButtonState: AppButtonState.enabled,
                        onClick: () {
                          _onSelectionChanged
                              .call(_calendarController.selectedRange);
                          Navigator.pop(context);
                        },
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white,
                        elevation: 0,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  void _onSelectionChanged(PickerDateRange? args) {
    List<DateTime> dates = [];
    if (args == null) {
      return;
    }
    if (args.startDate == null) {
      return;
    }
    dates.add(args.startDate!);
    dates.add(args.endDate ?? args.startDate!);
    onSelectedDatesChanged?.call(dates);
  }
}
