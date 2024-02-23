import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'image_button.dart';

class AcceptDeclineButtonView extends StatelessWidget {
  final Function? didClickAcceptButton;
  final Function? didClickRejectButton;
  const AcceptDeclineButtonView(
      {this.didClickAcceptButton, this.didClickRejectButton, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageButton(
            icon: Icons.close,
            height: 32,
            backgroundColor: AppColors.white,
            iconColor: AppColors.red,
            shadowColor: AppColors.red,
            spreadRadius: 1,
            onClick: didClickRejectButton),
        const SizedBox(
          width: 10,
        ),
        ImageButton(
            icon: Icons.check,
            height: 32,
            backgroundColor: AppColors.white,
            iconColor: AppColors.green,
            shadowColor: AppColors.green,
            spreadRadius: 1,
            onClick: didClickAcceptButton),
      ],
    );
  }
}
