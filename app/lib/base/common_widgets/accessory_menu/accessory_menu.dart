import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';

class AccessoryMenuEntry extends PopupMenuEntry<int> {
  @override
  final height = 200;
  final List<AccessoryMenuItem> menuItems;
  const AccessoryMenuEntry({required this.menuItems, Key? key})
      : super(key: key);

  @override
  bool represents(value) {
    return true;
  }

  @override
  AccessoryMenuEntryState createState() => AccessoryMenuEntryState();
}

class AccessoryMenuEntryState extends State<AccessoryMenuEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(children: widget.menuItems),
      ),
    );
  }
}

class AccessoryMenuItem extends StatelessWidget {
  final String title;
  final Color textColor;
  final Function? onPressed;
  const AccessoryMenuItem(
      {required this.title,
      this.onPressed,
      this.textColor = AppColors.primary,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: SizedBox(
        height: 45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Text(
              title,
              style: AppStyles.boldMedium(color: textColor),
            )
          ]),
        ),
      ),
    );
  }
}
