import 'package:flutter/material.dart';
import '../../utils/colors.dart';

@immutable
class CountrySelectionButton extends StatelessWidget {
  final String _countryCode;
  final String _countryImage;
  final Function? _onClick;
  final Color _backgroundColor;
  final double _width;
  final double _height;
  final TextStyle _textStyle;

  const CountrySelectionButton(
      {required String countryCode,
      required String countryImage,
      required Function? onClick,
      Color backgroundColor = AppColors.transparent,
      double width = 48,
      double height = 48,
      double imageHeight = 48,
      required TextStyle textStyle,
      Color shadowColor = AppColors.transparent,
      bool isCircular = false,
      double spreadRadius = 0,
      bool hasShadow = false,
      super.key})
      : _countryCode = countryCode,
        _countryImage = countryImage,
        _backgroundColor = backgroundColor,
        _width = width,
        _height = height,
        _textStyle = textStyle,
        _onClick = onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: GestureDetector(
        onTap: () {
          _onClick?.call();
        },
        child: Container(
          color: _backgroundColor,
          alignment: Alignment.center,
          child: Center(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    _countryImage,
                    style: _textStyle,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    _countryCode,
                    style: _textStyle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 1,
                    height: _height * 0.6,
                    color: AppColors.formTap,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
