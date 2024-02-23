import '../../../base/common_widgets/segmented_control_view/segmented_control_item.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

@immutable
class SegmentedControlItemView extends StatelessWidget {
  final SegmentedControlItem item;
  final Function(SegmentedControlItem)? onTapped;
  const SegmentedControlItemView(
      {required this.item, this.onTapped, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped?.call(item);
      },
      child: Container(
        decoration: BoxDecoration(
            color: item.backgroundColor,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppStyles.boldMedium(color: item.titleColor),
          ),
        ),
      ),
    );
  }
}
