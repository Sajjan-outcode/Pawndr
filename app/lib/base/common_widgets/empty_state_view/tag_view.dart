import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';

@immutable
class TagView extends StatelessWidget {
  final String title;
  final Function? onTap;
  const TagView({required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(50),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(title,
                style: AppStyles.boldSmall(color: AppColors.primary)),
          ),
        ),
      ),
    );
  }
}
