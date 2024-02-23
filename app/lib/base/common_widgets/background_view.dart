import 'package:flutter/material.dart';

import '../utils/colors.dart';

@immutable
class BackgroundView extends StatelessWidget {
  final String image;
  final Color overlayColor;
  final double opacity;
  const BackgroundView(
      {super.key,
      required this.image,
      this.overlayColor = AppColors.primaryElementColor,
      this.opacity = 0.7});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.black,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
                color: overlayColor,
                backgroundBlendMode: BlendMode.multiply,
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover, opacity: 1.0)),
          ),
        ),
        Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(opacity),
              backgroundBlendMode: BlendMode.multiply,
            )),
      ],
    );
  }
}
