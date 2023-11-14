
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';
import 'dimenestion.dart';



class AppText {
  static const TextStyle headline1 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 20, fontWeight: FontWeight.w500);
  static const TextStyle headline2 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 18, fontWeight: FontWeight.w500);
  static const TextStyle headline3 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 15, fontWeight: FontWeight.w500);
  static const TextStyle headline4 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle headline5 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 13, fontWeight: FontWeight.w500);
  static const TextStyle headline6 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 20, fontWeight: FontWeight.w500);
  static const TextStyle subHeadline1 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 20, fontWeight: FontWeight.w500);
  static const TextStyle subHeadline2 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 20, fontWeight: FontWeight.w500);
  static const TextStyle subHeadline3 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 20, fontWeight: FontWeight.w500);
  static const TextStyle subHeadline4 = TextStyle(
      color: AppTheme.primaryColor, fontSize: 20, fontWeight: FontWeight.w500);
}


class RegisterTextFieldWidget extends StatelessWidget {
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final Color? bgColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hint;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool? readOnly;
  final dynamic value = 0;
  final dynamic minLines;
  final dynamic maxLines;
  final bool? obscureText;
  final VoidCallback? onTap;
  final length;
  List<TextInputFormatter>? inputFormatters = [];
  RegisterTextFieldWidget({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.bgColor,
    this.validator,
    this.suffix,
    this.autofillHints,
    this.inputFormatters,
    this.prefix,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Color(0xFF384953)),
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly!,
      controller: controller,
      obscureText: hint == hint ? obscureText! : false,
      autofillHints: autofillHints,

      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: AppTheme.primaryColor,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(

          hintText: hint,
          focusColor: const Color(0xFF384953),
          hintStyle: GoogleFonts.quicksand(
            color: const Color(0xFF696969),
            textStyle: GoogleFonts.quicksand(
              color: const Color(0xFF696969),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            fontSize: 14,
            // fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(.10),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF384953).withOpacity(.24)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFF384953).withOpacity(.24)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          border: OutlineInputBorder(
              borderSide:
              BorderSide(color:const Color(0xFF384953).withOpacity(.24), width: 3.0),
              borderRadius: BorderRadius.circular(10.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}
class CommonButtonGreen extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButtonGreen({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppTheme.buttonColor),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(AddSize.screenWidth, AddSize.size50 * 1.2),
            backgroundColor: AppTheme.buttonColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // <-- Radius
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(title,
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: .5,
                  fontSize: 20))),
    );
  }
}
class CommonButton1 extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButton1({Key? key, required this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // gradient: const LinearGradient(
        //   // begin: Alignment.topCenter,
        //   // end: Alignment.bottomCenter,
        //     colors: [
        //       Color(0xFF7ED957),
        //       Color(0xff6BD13F)]
        // ),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(AddSize.screenWidth, AddSize.size50*1.2),
            backgroundColor: Color(0xff3797EF),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(title,
              style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: .5,
                  fontSize: 16))),
    );
  }
}

