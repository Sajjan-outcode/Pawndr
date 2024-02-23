import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../utils/app_styles.dart';
import '../../utils/colors.dart';

class FABActionItemView extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color backgroundColor;
  final double cornerRadius;
  final bool hasShadow;
  final Color shadowColor;
  final double spreadRadius;
  final Function? onPressed;
  final int angle;
  const FABActionItemView(
      {required this.title,
      required this.icon,
      this.backgroundColor = AppColors.secondaryLight,
      this.cornerRadius = 15,
      this.hasShadow = false,
      this.shadowColor = AppColors.secondaryElementColor,
      this.spreadRadius = 3,
      this.angle = 0,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyles.regularSmall(color: AppColors.secondaryLight),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            onPressed?.call();
          },
          child: SizedBox(
            width: 48,
            height: 48,
            child: Container(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
                boxShadow: hasShadow
                    ? [
                        BoxShadow(
                          color: shadowColor.withOpacity(0.2),
                          spreadRadius: spreadRadius,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: angle * math.pi / 180,
                    child: Container(
                      color: backgroundColor,
                      child: icon,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
