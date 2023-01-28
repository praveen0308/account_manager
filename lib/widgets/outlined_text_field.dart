import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String txt) onTextChanged;
  final Function(String txt) onSubmitted;
  final TextInputType inputType;
  final int maxLength;
  final String? hintText;
  final Widget? label;
  final EdgeInsetsGeometry? margin;
  final bool? autofocus;
  final TextInputAction? textInputAction;


  const OutlinedTextField({
    Key? key,
    required this.controller,
    required this.onTextChanged,
    required this.onSubmitted,
    required this.inputType,
    required this.maxLength,
    this.hintText,
    this.margin=const EdgeInsets.symmetric(vertical: 8,horizontal: 0), this.label,
    this.autofocus, this.textInputAction=TextInputAction.next
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 40,
      child: TextFormField(
        controller: controller,
        onChanged: onTextChanged,
        onFieldSubmitted: onSubmitted,
        maxLength: maxLength,
        maxLines: 1,
        keyboardType: inputType,
        autofocus: autofocus??false,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          label: label,
          hintText: hintText,
          counterText: "",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          fillColor: AppColors.primaryLight,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.primaryDarkest,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.primaryDark,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
