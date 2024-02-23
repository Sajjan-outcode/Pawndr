import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

class AcessoryBar extends StatelessWidget {
  final Function()? onCancelPressed;
  final Function()? onDonePressed;
  const AcessoryBar({this.onCancelPressed, this.onDonePressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _acessoryBarButton(
                title: "Cancel", onButtonpressed: onCancelPressed),
            _acessoryBarButton(title: "Done", onButtonpressed: onDonePressed)
          ],
        ),
      ),
    );
  }

  Widget _acessoryBarButton(
      {required String title, required Function()? onButtonpressed}) {
    return GestureDetector(
      onTap: onButtonpressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          title,
          style: AppStyles.boldMedium(),
        ),
      ),
    );
  }
}
