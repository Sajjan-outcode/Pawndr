import 'package:flutter/material.dart';

import 'colors.dart';

class AppStyles {
  //////////////////////////////////////////////////////////////////////////////////////////
  // all heading appstyles
  static heading1({Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 32, color: color, fontWeight: FontWeight.w900);
  static TextStyle heading2({Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 27, color: color, fontWeight: FontWeight.w900);
  static TextStyle heading3({Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 19, color: color, fontWeight: FontWeight.w900);

  //////////////////////////////////////////////////////////////////////////////////////////

  /// ALl bold styles

  static TextStyle bold(
          {Color color = AppColors.primaryElementColor, double size = 24}) =>
      TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w700);

  static TextStyle regular(
          {Color color = AppColors.primaryElementColor, double size = 24}) =>
      TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w400);

  static TextStyle boldExtraLarge(
          {Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldLarge({Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldMedium({Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldRegular({Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 15, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldSmall({Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldExtraSmall(
          {Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w700);
  /////////////////////////////////////////////////////////////////////////////////////////

  ///All regular styles
  static TextStyle regularExtraLarge(
          {Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w400);
  static TextStyle regularLarge(
          {Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w400);
  static TextStyle regularMedium(
          {Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w400);
  static TextStyle regularSmall(
          {Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w400);
  static TextStyle regularExtraSmall(
          {Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w400);

  //////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle caption({Color color = AppColors.primaryElementColor}) =>
      TextStyle(
        fontSize: 10,
        color: color,
        fontWeight: FontWeight.w500,
      );

  //////////////////////////////////////////////////////////////////////////////////////////

  // All text field styles
  static TextStyle placeholder(
          {Color color = AppColors.secondaryElementColor}) =>
      TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.w400,
      );

  static TextStyle textFieldTextStyle(
          {Color color = AppColors.primaryElementColor}) =>
      TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w500);

  static outlinedInputBorder(
          {bool hasValidationError = false,
          Color borderColor = AppColors.transparent}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
            width: hasValidationError ? 1.0 : 1.0,
            color: hasValidationError ? AppColors.red : borderColor),
        borderRadius: BorderRadius.circular(16.0),
      );

  //////////////////////////////////////////////////////////////////////////////////////////

  /// All button Styles
  static TextStyle buttonWhiteTextSmall(Color color) => TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  //////////////////////////////////////////////////////////////////////////////////////////
  ///
  static textViewBorder() => OutlineInputBorder(
        borderSide: const BorderSide(width: 0.0, color: AppColors.transparent),
        borderRadius: BorderRadius.circular(0.0),
      );

  static BoxDecoration bottomSheetBoxDecoration() => BoxDecoration(
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(1, -1), // changes position of shadow
        )
      ],
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));
}
