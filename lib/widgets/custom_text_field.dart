import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;

  final Icon? prefixIon;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? suffix;
  final bool readOnly;
  final Function? onTap;
  final int? minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final double? borderRadius;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Function(String)? onChange;
  final AutovalidateMode? autovalidateMode;
  const CustomTextfield(
      {super.key,
      required this.hintText,
      this.prefixIon,
      this.obsecureText = false,
      this.validator,
      this.keyboardType,
      this.controller,
      this.suffix,
      this.readOnly = false,
      this.onTap,
      this.focusNode,
      this.minLines,
      this.maxLines = 1,
      this.enabledBorder,
      this.focusedBorder,
      this.borderRadius,
      this.onChange,
      this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      focusNode: focusNode,
      minLines: minLines,
      maxLines: maxLines,
      // style: const TextStyle(
      //     fontFamily: AppTextStyles.fontFamily,
      //     color: AppColors.white,
      //     fontSize: 14),
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obsecureText,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        suffixIcon: suffix,
        prefixIcon: prefixIon,
        filled: true,
        //fillColor: AppColors.textFieldColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: const TextStyle(
          //fontFamily: AppTextStyles.fontFamily,
          color: Color(0xff9F9F9F),
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }
}
