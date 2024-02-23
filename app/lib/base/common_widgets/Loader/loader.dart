// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../utils/colors.dart';

@immutable
class Loader extends StatelessWidget {
  final Color color;
  final double _size;
  final double _strokeWidth;
  const Loader(
      {super.key,
      this.color = AppColors.primary,
      double strokeWidth = 2.0,
      double size = 25.0})
      : _strokeWidth = strokeWidth,
        _size = size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: _size,
        height: _size,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: _strokeWidth,
        ),
      ),
    );
  }
}
