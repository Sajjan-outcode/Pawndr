import '../../utils/strings.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';
import '../buttons/app_button.dart';
import '../buttons/app_button_state.dart';

class ActionSheet extends StatelessWidget {
  final String title;
  final List<Widget> actionItems;
  const ActionSheet(
      {required this.title, required this.actionItems, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(),
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title.localized,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.regularMedium(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(actionItems.length, (index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 0.5,
                                  child:
                                      Container(color: AppColors.primaryLight),
                                ),
                                actionItems[index]
                              ],
                            );
                          }),
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppButton(
                        title: "Cancel",
                        textColor: AppColors.red,
                        backgroundColor: AppColors.white,
                        appButtonState: AppButtonState.enabled,
                        onClick: () {
                          Navigator.pop(context);
                        })
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
