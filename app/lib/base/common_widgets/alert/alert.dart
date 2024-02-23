import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';

class Alert {
  static void showAlert(BuildContext context, Function onClickOK,
      {String? title,
      String? message,
      String okTitle = 'Ok',
      Function? onCancelClick,
      String cancelTitle = "Cancel"}) {
    List<Widget> actions = [];
    actions.add(Expanded(
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        height: 45,
        minWidth: 100,
        color: AppColors.primary,
        onPressed: () {
          onClickOK();
        },
        child: Text(
          okTitle,
          style: AppStyles.regularSmall(color: AppColors.white),
        ),
      ),
    ));
    if (onCancelClick != null) {
      actions.add(const SizedBox(
        width: 10,
      ));
      actions.add(Expanded(
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          height: 45,
          minWidth: 100,
          elevation: 0,
          color: AppColors.white,
          onPressed: () {
            onCancelClick.call();
          },
          child: Text(
            cancelTitle,
            style: AppStyles.regularSmall(color: AppColors.red),
          ),
        ),
      ));
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.background),
                child: Column(
                  children: [
                    title != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              title,
                              style: AppStyles.boldMedium(),
                            ),
                          )
                        : Container(),
                    message != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child:
                                Text(message, style: AppStyles.regularSmall()),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: actions,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
