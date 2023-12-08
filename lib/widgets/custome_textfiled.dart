import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/widgets/app_theme.dart';
import 'app_assets.dart';
import 'dimenestion.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  RxBool? obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final RxString hintText;
  final Widget? suffixIcon;
  final Widget? prefix;

  List<TextInputFormatter>? inputFormatters1 = [];

  CustomTextField({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters1,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
          cursorColor: const Color(0xFF7ED957),
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters1,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingCompleted,
          obscureText: widget.obSecure!.value,
          minLines: widget.isMulti ? 4 : 1,
          maxLines: widget.isMulti ? null : 1,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            counter: const Offstage(),
            filled: true,
            errorMaxLines: 2,
            enabled: widget.enabled,
            fillColor: Colors.transparent,
            hintText: widget.hintText.value,
            errorText: widget.errorText,
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.black),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon,
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xff2F353F),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            /*errorStyle: const TextStyle(
              overflow: TextOverflow.clip,
            ),*/
            contentPadding: const EdgeInsets.only(left: 10, top: 15),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0)),
          ),
          validator: widget.validator);
    });
  }
}

class CustomTextField1 extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  RxBool? obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final RxString hintText;
  final Widget? suffixIcon;
  final Widget? prefix;

  List<TextInputFormatter>? inputFormatters1 = [];

  CustomTextField1({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters1,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextField1> createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
          cursorColor: const Color(0xFF7ED957),
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters1,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingCompleted,
          obscureText: widget.obSecure!.value,
          minLines: widget.isMulti ? 4 : 1,
          maxLines: widget.isMulti ? null : 1,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            counter: const Offstage(),
            filled: true,
            errorMaxLines: 2,
            enabled: widget.enabled,
            fillColor: Colors.transparent,
            hintText: widget.hintText.value,
            errorText: widget.errorText,
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.black),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon,
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xff2F353F),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            /*errorStyle: const TextStyle(
              overflow: TextOverflow.clip,
            ),*/
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF34472C).withOpacity(0.21),
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF34472C).withOpacity(0.21),
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF34472C).withOpacity(0.21),
                ),
                borderRadius: BorderRadius.circular(100.0)),
          ),
          validator: widget.validator);
    });
  }
}

class CustomTextField2 extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  RxBool? obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final RxString hintText;
  final Widget? suffixIcon;
  final Widget? prefix;

  List<TextInputFormatter>? inputFormatters1 = [];

  CustomTextField2({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters1,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
          cursorColor: const Color(0xFF7ED957),
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters1,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingCompleted,
          obscureText: widget.obSecure!.value,
          minLines: widget.isMulti ? 4 : 1,
          maxLines: widget.isMulti ? null : 1,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            counter: const Offstage(),
            filled: true,
            errorMaxLines: 2,
            enabled: widget.enabled,
            fillColor: Colors.transparent,
            hintText: widget.hintText.value,
            errorText: widget.errorText,
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.black),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon,
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xff2F353F),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            /*errorStyle: const TextStyle(
              overflow: TextOverflow.clip,
            ),*/
            contentPadding: const EdgeInsets.only(left: 10, top: 60),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF34472C).withOpacity(0.21),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF34472C).withOpacity(0.21),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF34472C).withOpacity(0.21),
                ),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          validator: widget.validator);
    });
  }
}

// custom button

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: AppTheme.primaryColor),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(AddSize.screenWidth, AddSize.size50 * 1.0),
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            title,
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
          )),
    );
  }
}
class CommonButton2 extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButton2({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: AppTheme.primaryColor),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(AddSize.size30, AddSize.size40 * .2),
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            title,
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
          )),
    );
  }
}

class CommonButton1 extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButton1({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            colors: [Color(0xFF7ED957), Color(0xff6BD13F)]),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(AddSize.screenWidth, AddSize.size50 * 1.2),
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            title,
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white),
          )),
    );
  }
}

AppBar backAppBar(
    {required title,
    required BuildContext context,
    String dispose = "",
    Color? backgroundColor = Colors.white,
    Color? textColor = Colors.black,
    Widget? icon,
    disposeController}) {
  return AppBar(
    //shadowColor:  Colors.grey[400],
    toolbarHeight: 60,
    elevation: 0,
    titleSpacing: 30,
    surfaceTintColor: Colors.grey.shade300,
    leadingWidth: AddSize.size40 * 0.9,
    backgroundColor: backgroundColor,
    title: Text(
      title,
      style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: const Color(0xFF303C5E)),
    ),
    leading: Padding(
      padding: EdgeInsets.only(left: AddSize.padding12),
      child: GestureDetector(
          onTap: () {
            Get.back();
            if (dispose == "dispose") {}
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [icon ?? SvgPicture.asset(AppAssets.arrowBack)],
          )),
    ),
  );
}

class CommonTextFieldWidget extends StatelessWidget {
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

  const CommonTextFieldWidget({
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
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly!,
      controller: controller,
      obscureText: hint == hint ? obscureText! : false,
      autofillHints: autofillHints,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: const Color(0xFF7ED957),
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(
          hintText: hint,
          focusColor: Colors.black,
          hintStyle: const TextStyle(
            color: Color(0xff2F353F),
            fontSize: 14,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD8DCDD), width: 3.0),
              borderRadius: BorderRadius.circular(15.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}

class CommonTextFieldWidget1 extends StatelessWidget {
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

  const CommonTextFieldWidget1({
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
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly!,
      controller: controller,
      obscureText: hint == hint ? obscureText! : false,
      autofillHints: autofillHints,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: const Color(0xFF7ED957),
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(
          hintText: hint,
          focusColor: Colors.black,
          hintStyle: const TextStyle(
            color: Color(0xff2F353F),
            fontSize: 14,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD8DCDD), width: 3.0),
              borderRadius: BorderRadius.circular(15.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}

class RegistrationTextFieldChk extends StatelessWidget {
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
  final TextEditingController? controller;
  final bool? readOnly;
  final dynamic value = 0;
  final dynamic minLines;
  final dynamic maxLines;
  final bool? obscureText;
  final bool? enable;
  final VoidCallback? onTap;
  final length;

  const RegistrationTextFieldChk({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
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
    this.readOnly = false,
    this.onTap,
    this.enable,
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
          focusColor: Colors.green,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF697164),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: const Color(0xFFF4F4F4),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE2E2E2), width: 1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE2E2E2), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE2E2E2), width: 1),
              borderRadius: BorderRadius.circular(6.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}

class RegistrationTextFieldChk1 extends StatelessWidget {
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
  final TextEditingController? controller;
  final bool? readOnly;
  final dynamic value = 0;
  final dynamic minLines;
  final dynamic maxLines;
  final bool? obscureText;
  final bool? enable;
  final VoidCallback? onTap;
  final length;

  const RegistrationTextFieldChk1({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
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
    this.readOnly = false,
    this.onTap,
    this.enable,
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
          focusColor: Colors.green,
          hintStyle: GoogleFonts.raleway(
            color: const Color(0xFF463C3E),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: const Color(0xFFF0F0F0),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE2E2E2), width: 1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE2E2E2), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE2E2E2), width: 1),
              borderRadius: BorderRadius.circular(6.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}

class RegistrationTextField extends StatelessWidget {
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
  final TextEditingController? controller;
  final bool? readOnly;
  final dynamic value = 0;
  final dynamic minLines;
  final dynamic maxLines;
  final bool? obscureText;
  final bool? enable;
  final VoidCallback? onTap;
  final length;

  const RegistrationTextField({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
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
    this.readOnly = false,
    this.onTap,
    this.enable,
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
          focusColor: Colors.green,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0x000000).withOpacity(0.57),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Color(0xFFFFFFFF),
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

class RegistrationTextField1 extends StatelessWidget {
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
  final TextEditingController? controller;
  final bool? readOnly;
  final dynamic value = 0;
  final dynamic minLines;
  final dynamic maxLines;
  final bool? obscureText;
  final bool? enable;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final length;
  final String? lableText;
  final dynamic errorMaxLines;

  const RegistrationTextField1(
      {Key? key,
      this.suffixIcon,
      this.prefixIcon,
      this.hint,
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
      this.readOnly = false,
      this.onTap,
      this.enable,
      this.length,
      this.onChanged,
      this.lableText,
      this.errorMaxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly!,
      controller: controller,
      onChanged: onChanged,
      obscureText: hint == hint ? obscureText! : false,
      autofillHints: autofillHints,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      enabled: enable,
      //lableText: lableText,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      cursorColor: Colors.green,
      decoration: InputDecoration(
          errorMaxLines: 2,
          hintText: hint,
          focusColor: Colors.green,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xff2F353F),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          labelStyle: GoogleFonts.poppins(
            color: const Color(0xff2F353F),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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

class RegistrationTextField2 extends StatelessWidget {
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
  final TextEditingController? controller;
  final bool? readOnly;
  final dynamic value = 0;
  final dynamic minLines;
  final dynamic maxLines;
  final bool? obscureText;
  final bool? enable;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final length;

  const RegistrationTextField2({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
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
    this.readOnly = false,
    this.onTap,
    this.enable,
    this.length,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly!,
      controller: controller,
      onChanged: onChanged,
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
          focusColor: Colors.green,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xff2F353F),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            //borderRadius: const BorderRadius.all(Radius.circular(10.0))
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 3.0),
              borderRadius: BorderRadius.circular(15.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}

class RegistrationTextField3 extends StatelessWidget {
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
  final TextEditingController? controller;
  final bool? readOnly;
  final dynamic value = 0;
  final dynamic minLines;
  final dynamic maxLines;
  final bool? obscureText;
  final bool? enable;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final length;

  const RegistrationTextField3({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
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
    this.readOnly = false,
    this.onTap,
    this.enable,
    this.length,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly!,
      controller: controller,
      onChanged: onChanged,
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
          focusColor: Colors.green,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xff2F353F),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            //borderRadius: const BorderRadius.all(Radius.circular(10.0))
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 3.0),
              borderRadius: BorderRadius.circular(15.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}
