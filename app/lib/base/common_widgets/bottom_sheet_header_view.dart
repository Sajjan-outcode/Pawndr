import '../../base/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_styles.dart';
import '../utils/colors.dart';

class BottomSheetHeaderView extends StatelessWidget {
  final String title;
  final Function? onclosePressed;
  const BottomSheetHeaderView(
      {required this.title, this.onclosePressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title.localized,
            style: AppStyles.heading3(),
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.xmark,
              color: AppColors.primaryElementColor,
            ))
      ],
    );
  }
}
