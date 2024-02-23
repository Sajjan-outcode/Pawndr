import 'dart:ui';

import '../app_button_state.dart';

abstract class AppButtonDecorator {
  Color getBackgroundColor(AppButtonState appButtonState);
  Color getTitleColor(AppButtonState appButtonState);
}
