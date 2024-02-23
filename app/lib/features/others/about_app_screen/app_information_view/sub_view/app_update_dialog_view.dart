import 'package:flutter/material.dart';

import '../../../../../base/utils/colors.dart';
import '../../../../../core/domain/domain_models/app_info_domain.dart';
import '../app_version_info_view_type.dart';
import 'app_update_view.dart';

class AppUpdateDialogView extends StatelessWidget {
  final AppVersionInfoViewType viewType;
  final AppInfoDomain appInformation;
  final Function? onButtonClicked;
  const AppUpdateDialogView(
      {required this.viewType,
      required this.appInformation,
      this.onButtonClicked,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bottomsheetBarrierColor.withOpacity(0.5),
      child: Center(
        child: AppUpdateView(
          viewType: viewType,
          appInformation: appInformation,
          onButtonClicked: onButtonClicked,
        ),
      ),
    );
  }
}
