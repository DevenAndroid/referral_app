import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'dimenestion.dart';

class EditProfileTextFieldWidget extends StatelessWidget {
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final Color? bgColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hint;
  final String? label;
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final bool? readOnly;
  final int? value = 0;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final bool? enable;
  final VoidCallback? onTap;
  final length;

  const EditProfileTextFieldWidget({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.label,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.bgColor,
    this.validator,
    this.suffix,
    this.autofillHints,
    this.prefix,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.enable,
    this.readOnly = false,
    this.onTap,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly!,
      controller: controller,
      obscureText: hint == hint ? obscureText! : false,
      autofillHints: autofillHints,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      enabled: enable,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(
          hintText: hint,
          focusColor: AppTheme.primaryColor,
          hintStyle:
          TextStyle(color: Color(0xffADADB8), fontSize: AddSize.font14),
          labelText: label,
          labelStyle: TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
          filled: true,
          fillColor: const Color(0xFFF3F3F3),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(4.0))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 3.0),
              borderRadius: BorderRadius.circular(4.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}

class EditProfileTextFieldWidget1 extends StatelessWidget {
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final Color? bgColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hint;
  final String? label;
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final bool? readOnly;
  final int? value = 0;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final bool? enable;
  final VoidCallback? onTap;
  final length;

  const EditProfileTextFieldWidget1({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.label,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.bgColor,
    this.validator,
    this.suffix,
    this.autofillHints,
    this.prefix,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.enable,
    this.readOnly = false,
    this.onTap,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: false,
      controller: controller,
      obscureText: hint == hint ? obscureText! : false,
      autofillHints: autofillHints,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      enabled: enable,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(
          hintText: hint,
          focusColor: AppTheme.primaryColor,
          hintStyle:
          GoogleFonts.ibmPlexSansArabic(color: Color(0xffACACB7), fontSize: AddSize.font14,fontWeight:FontWeight.w700),
          labelText: label,
          labelStyle: TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
          filled: true,
          fillColor: AppTheme.backgroundcolor,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 3.0),
              borderRadius: BorderRadius.circular(15.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}