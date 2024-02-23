import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../base/common_widgets/buttons/app_button.dart';
import '../../../../../base/common_widgets/buttons/app_button_state.dart';
import '../../../../../base/utils/app_styles.dart';
import '../../../../../base/utils/colors.dart';
import '../../../../../core/domain/domain_models/app_info_domain.dart';
import '../app_version_info_view_type.dart';

class AppUpdateView extends StatelessWidget {
  final AppVersionInfoViewType viewType;
  final AppInfoDomain appInformation;
  final Function? onButtonClicked;
  const AppUpdateView(
      {required this.viewType,
      required this.appInformation,
      this.onButtonClicked,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: viewType.backgroundColor),
            child: Column(children: [
              Text(
                viewType.headerTitle,
                style: AppStyles.heading3(),
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: appInformation.showsAppIcon,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: viewType.imageWidget,
                ),
              ),
              Visibility(
                visible: viewType.detail != null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: viewType.detail ?? Container(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Version ${appInformation.versionName} (build ${appInformation.buildNumber})",
                  style: AppStyles.regularLarge(),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  !appInformation.hasAppUpdate
                      ? "Up to Date!"
                      : "A new version is available!",
                  style:
                      AppStyles.caption(color: AppColors.secondaryElementColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(
                visible:
                    appInformation.hasAppUpdate && viewType.showsUpdateButton,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 8),
                  child: AppButton(
                      title: "Update Now",
                      appButtonState: AppButtonState.enabled,
                      textColor: AppColors.white,
                      onClick: () {
                        Navigator.pop(context);
                        onButtonClicked?.call();
                        _openAppStore(context);
                      }),
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  _openAppStore(BuildContext context) {
    if ((appInformation.link ?? "").isNotEmpty) {
      launchUrlString(appInformation.link!,
          mode: LaunchMode.externalApplication);
    }
  }
}
