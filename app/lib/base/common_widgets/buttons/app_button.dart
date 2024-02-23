import '../../utils/strings.dart';
import 'package:flutter/material.dart';
import '../../utils/app_styles.dart';
import '../../utils/colors.dart';
import 'app_button_state.dart';
import 'decorators/gola_bud_app_button_decorator.dart';

class AppButton extends StatelessWidget {
  final String _title;
  final AppButtonState _appButtonState;
  final Function? _onClick;
  final Color _backgroundColor;
  final Color? _textColor;
  final double _height;
  final double _radius;
  final double _elevation;
  final AppButtonDecorator? _button;

  const AppButton(
      {required String title,
      required AppButtonState appButtonState,
      required Function? onClick,
      Color backgroundColor = AppColors.primary,
      Color? textColor,
      double height = 56,
      double radius = 16,
      double elevation = 2,
      AppButtonDecorator? button,
      super.key})
      : _title = title,
        _appButtonState = appButtonState,
        _backgroundColor = backgroundColor,
        _textColor = textColor,
        _height = height,
        _radius = radius,
        _elevation = elevation,
        _button = button,
        _onClick = onClick;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MaterialButton(
        onPressed:
            _appButtonState == AppButtonState.disabled ? null : _onButtonClick,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius)),
        height: _height,
        elevation: _elevation == 0
            ? 0
            : (_appButtonState != AppButtonState.disabled ? 2.0 : _elevation),
        color: _button?.getBackgroundColor(_appButtonState) ?? _backgroundColor,
        textColor: _button?.getTitleColor(_appButtonState) ?? _textColor,
        disabledColor: _button?.getBackgroundColor(AppButtonState.disabled) ??
            _backgroundColor,
        disabledTextColor:
            _button?.getTitleColor(AppButtonState.disabled) ?? _textColor,
        minWidth: double.maxFinite,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.transparent,
        highlightColor: _button?.getBackgroundColor(AppButtonState.tapped) ??
            _backgroundColor,
        enableFeedback: false,
        child: Text(
          _title.localized,
          style: AppStyles.buttonWhiteTextSmall((_textColor == null)
              ? _button?.getTitleColor(_appButtonState) ?? AppColors.primary
              : _textColor!),
        ),
      ),
    ]);
  }

  _onButtonClick() {
    _onClick?.call();
  }
}
