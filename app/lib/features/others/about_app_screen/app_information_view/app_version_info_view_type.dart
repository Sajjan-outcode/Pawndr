import 'package:app/base/common_widgets/image_widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../base/utils/app_styles.dart';
import '../../../../base/utils/colors.dart';
import '../../../../base/utils/images.dart';

enum AppVersionInfoViewType { normal, dialog }

extension AppVersionInfoViewTypeExtension on AppVersionInfoViewType {
  String get headerTitle {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return "Trackify";
      case AppVersionInfoViewType.dialog:
        return "Update Available";
    }
  }

  Color get backgroundColor {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return Colors.transparent;
      case AppVersionInfoViewType.dialog:
        return AppColors.white;
    }
  }

  Widget get imageWidget {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return AppImageView(
          initialsText: "",
          height: 80,
          width: 80,
        );
      case AppVersionInfoViewType.dialog:
        return Lottie.asset('assets/lottie/logoAnimate.json',
            width: 500, repeat: true);
    }
  }

  Widget? get detail {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return null;
      case AppVersionInfoViewType.dialog:
        return Text(
          "Access new tools and features with the latest app version.",
          style: AppStyles.heading3(color: AppColors.secondaryElementColor),
          textAlign: TextAlign.center,
        );
    }
  }

  bool get showsUpdateButton {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return true;
      case AppVersionInfoViewType.dialog:
        return true;
    }
  }
}
