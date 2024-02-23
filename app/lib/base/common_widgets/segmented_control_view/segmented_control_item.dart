import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class SegmentedControlItem {
  final int index;
  final String title;
  final Color _selectedBackgroundColor;
  final Color _unselectedBackgroundColor;
  final Color _selectedTitleColor;
  final Color _unselectedTitleColor;
  final Function? onTapped;
  bool isSelected = false;

  SegmentedControlItem(
      {required this.index,
      required this.title,
      Color selectedBackgroundColor = AppColors.primary,
      Color unselectedBackgroundColor = AppColors.primaryLight,
      Color selectedTitleColor = AppColors.white,
      Color unselectedTitleColor = AppColors.white,
      this.isSelected = false,
      this.onTapped})
      : _selectedBackgroundColor = selectedBackgroundColor,
        _unselectedBackgroundColor = unselectedBackgroundColor,
        _selectedTitleColor = selectedTitleColor,
        _unselectedTitleColor = unselectedTitleColor;

  Color get backgroundColor =>
      isSelected ? _selectedBackgroundColor : _unselectedBackgroundColor;
  Color get titleColor =>
      isSelected ? _selectedTitleColor : _unselectedTitleColor;
}
