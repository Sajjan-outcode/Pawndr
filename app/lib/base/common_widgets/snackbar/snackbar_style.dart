import 'package:flutter/material.dart';

import '../../utils/colors.dart';

enum SnackbarStyle { error, success, normal, validationError }

extension SnackbarStyleExtension on SnackbarStyle {
  Color get displayTitleColor {
    switch (this) {
      case SnackbarStyle.error:
        return AppColors.red;
      case SnackbarStyle.success:
        return AppColors.white;
      case SnackbarStyle.normal:
        return AppColors.white;
      case SnackbarStyle.validationError:
        return AppColors.red;
    }
  }

  Color get displayBackgroundColor {
    switch (this) {
      case SnackbarStyle.error:
        return AppColors.snackbarErrorBackground;
      case SnackbarStyle.success:
        return AppColors.green;
      case SnackbarStyle.normal:
        return AppColors.primaryLight;
      case SnackbarStyle.validationError:
        return AppColors.snackbarErrorBackground;
    }
  }
}
