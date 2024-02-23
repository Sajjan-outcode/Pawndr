import 'dart:ui';

import '../../../utils/colors.dart';
import '../app_button_state.dart';
import 'gola_bud_app_button_decorator.dart';

class TertiaryButtonDecorator extends AppButtonDecorator {
  double backgroundOpacity = 1;

  TertiaryButtonDecorator({this.backgroundOpacity = 1});
  @override
  Color getBackgroundColor(AppButtonState appButtonState) {
    switch (appButtonState) {
      case AppButtonState.enabled:
        return AppColors.white.withOpacity(backgroundOpacity);
      case AppButtonState.tapped:
        return AppColors.primaryLight;
      case AppButtonState.disabled:
        return AppColors.white;
    }
  }

  @override
  Color getTitleColor(AppButtonState appButtonState) {
    switch (appButtonState) {
      case AppButtonState.enabled:
        return AppColors.primary;
      case AppButtonState.tapped:
        return AppColors.primary;
      case AppButtonState.disabled:
        return AppColors.white;
    }
  }
}
