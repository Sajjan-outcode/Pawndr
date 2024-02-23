import 'dart:ui';

import '../../../utils/colors.dart';
import '../app_button_state.dart';
import 'gola_bud_app_button_decorator.dart';

class PrimaryButtonDecorator extends AppButtonDecorator {
  double backgroundOpacity = 1;

  PrimaryButtonDecorator({this.backgroundOpacity = 1});

  @override
  Color getBackgroundColor(AppButtonState appButtonState) {
    switch (appButtonState) {
      case AppButtonState.enabled:
        return AppColors.primary.withOpacity(backgroundOpacity);
      case AppButtonState.tapped:
        return AppColors.primaryDark;
      case AppButtonState.disabled:
        return AppColors.tertiaryElementColor;
    }
  }

  @override
  Color getTitleColor(AppButtonState appButtonState) {
    return AppColors.white;
  }
}
