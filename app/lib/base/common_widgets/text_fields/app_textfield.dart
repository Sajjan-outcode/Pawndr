import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';

class AppTextField {
  static Widget textField(
      {required String hint,
      required Color backgroundColor,
      required String? Function() validator,
      required TextEditingController controller,
      Function(String)? onTextChanged,
      Function(String)? onFieldSubmitted,
      Function()? onTap,
      TextInputType keyboardType = TextInputType.text,
      TextCapitalization textCapitalization = TextCapitalization.none,
      Function? onObscureTapped,
      bool isPasswordField = false,
      Color borderColor = AppColors.transparent,
      bool isObsecured = false,
      String? headerTitle,
      Widget? suffixIcon,
      Widget? prefixIcon,
      FocusNode? focusNode,
      int? maxLines,
      Color textColor = AppColors.primaryElementColor,
      bool hasError = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: headerTitle != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                headerTitle ?? '',
                style: AppStyles.boldMedium(),
              ),
            )),
        TextFormField(
          controller: controller,
          style: AppStyles.textFieldTextStyle(color: textColor),
          validator: (value) => validator.call(),
          onChanged: onTextChanged,
          focusNode: focusNode,
          obscureText: isObsecured,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization,
          onTap: onTap,
          maxLines: maxLines,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            fillColor:
                hasError ? AppColors.red.withOpacity(0.1) : backgroundColor,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            labelText: hint,
            hintStyle: AppStyles.placeholder(),
            alignLabelWithHint: true,
            labelStyle: AppStyles.placeholder(),
            border: AppStyles.outlinedInputBorder(
                hasValidationError: hasError, borderColor: borderColor),
            enabledBorder: AppStyles.outlinedInputBorder(
                hasValidationError: hasError, borderColor: borderColor),
            focusedBorder: AppStyles.outlinedInputBorder(
                hasValidationError: hasError, borderColor: borderColor),
          ),
        ),
      ],
    );
  }
}
