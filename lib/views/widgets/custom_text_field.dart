import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextStyle? inputTextStyle;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
      this.maxLines,
      this.obscureText = false,
      required this.validator,
      this.inputTextStyle,
      required TextInputAction textInputAction,
      required TextInputType keyboardType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: "Input field",
      textField: true,
      hint: "Enter $hintText",
      child: TextFormField(
        maxLines: maxLines ?? 1,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        cursorColor: theme.textTheme.bodyLarge?.color,
        cursorErrorColor: Colors.red,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.emailAddress,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        style: inputTextStyle ??
            TextStyle(color: theme.textTheme.bodyLarge?.color),
        // Apply the user input text style or default one
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: theme.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.indicatorColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          hintText: hintText,
         // hintTextDirection: TextDirection.rtl,
          hintStyle: inputTextStyle ??
              TextStyle(
                  color: theme.textTheme.bodyMedium
                      ?.color), // Apply the hint style as well
        ),
      ),
    );
  }
}
