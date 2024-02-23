import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';
import 'tag_view.dart';

@immutable
class EmptyStateView extends StatelessWidget {
  final String? imageString;
  final String? title;
  final String? detailText;
  final double? fraction;
  final List<TagView> tags;
  final Color? backgroundColor;
  const EmptyStateView(
      {this.imageString,
      this.title,
      this.detailText,
      this.backgroundColor,
      this.fraction,
      required this.tags,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          imageString == null
              ? const SizedBox.shrink()
              : FractionallySizedBox(
                  widthFactor: fraction ?? 0.5,
                  child: Image(image: AssetImage(imageString!))),
          Visibility(
            visible: title != null,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 10, top: imageString == null ? 0 : 10),
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style:
                    AppStyles.heading3(color: AppColors.secondaryElementColor),
              ),
            ),
          ),
          Visibility(
            visible: detailText != null,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                detailText ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.secondaryElementColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: tags,
            ),
          )
        ]),
      ),
    );
  }
}
