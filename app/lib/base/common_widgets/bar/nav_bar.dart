import '../../utils/strings.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';

enum NavStyle { singleLined, doubleLined }

extension NavStyleExtension on NavStyle {
  MainAxisAlignment get alignment {
    switch (this) {
      case NavStyle.singleLined:
        return MainAxisAlignment.start;
      case NavStyle.doubleLined:
        return MainAxisAlignment.spaceBetween;
    }
  }
}

class NavBar extends StatelessWidget {
  final String navTitle;
  final String? title;
  final bool showsLeftButton;
  final Function()? onBackButtonClicked;
  final List<Widget>? sideMenuItems;
  final Color backgroundColor;
  final NavStyle navStyle;
  final IconData icon;
  final Color leftButtonColor;
  final Color backButtonColor;
  final TextAlign singleLineTextAlign;
  final Color textColor;
  const NavBar(
      {this.navTitle = "",
      this.title,
      required this.navStyle,
      required this.icon,
      this.backgroundColor = AppColors.primary,
      this.leftButtonColor = AppColors.white,
      this.showsLeftButton = false,
      this.backButtonColor = AppColors.primary,
      this.textColor = AppColors.primaryElementColor,
      this.singleLineTextAlign = TextAlign.center,
      this.onBackButtonClicked,
      this.sideMenuItems,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _navComponent(),
            title == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            (title ?? '').localized,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.heading2(color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _navComponent() {
    return navStyle == NavStyle.singleLined
        ? _singleLinedWrapper()
        : _doubleLinedWrapper();
  }

  _singleLinedWrapper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          child: Visibility(
            visible: showsLeftButton,
            child: IconButton(
                onPressed: () {
                  onBackButtonClicked?.call();
                },
                icon: Icon(
                  icon,
                  size: 30,
                  color: leftButtonColor,
                )),
          ),
        ),
        Expanded(
          child: Text(
            navTitle.localized,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: singleLineTextAlign,
            style: title == null
                ? AppStyles.heading3(color: textColor)
                : AppStyles.boldLarge(color: textColor),
          ),
        ),
        _sideMenus()
      ],
    );
  }

  _doubleLinedWrapper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                  child: Visibility(
                    visible: showsLeftButton,
                    child: IconButton(
                        onPressed: () {
                          onBackButtonClicked?.call();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.primary,
                        )),
                  ),
                ),
                Expanded(
                  child: Text(
                    navTitle.localized,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: title == null
                        ? AppStyles.heading3()
                        : AppStyles.boldLarge(color: AppColors.primary),
                  ),
                ),
              ]),
        ),
        _sideMenus()
      ],
    );
  }

  _sideMenus() {
    return (sideMenuItems ?? []).isEmpty
        ? const SizedBox(
            width: 50,
          )
        : Row(
            children: sideMenuItems ?? [],
          );
  }
}
