import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme.dart';




class CommonTextfield extends StatefulWidget {

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obSecure;
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
  // final bool disable;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;

  List<TextInputFormatter>? inputFormatters = [];

  CommonTextfield({super.key,
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
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(

        style: const TextStyle(
            color: AppTheme.textColor
        ),
        autofocus: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingCompleted,
        obscureText: widget.obSecure,
        minLines: widget.isMulti ? 4 : 1,
        maxLines: widget.isMulti ? null : 1,
        onTap: widget.onTap,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        focusNode: _focusNode,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(

          counterStyle: const TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 25,
          ),
          counter: const Offstage(),
          //    filled: true,
          errorMaxLines: 2,
          enabled: widget.enabled,
          //   fillColor: Colors.transparent,
          hintText: widget.hintText,
          errorText: widget.errorText,
          labelText: widget.labelText,
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffixIcon,
          labelStyle: const TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 15,
          ),
          hintStyle: const TextStyle(

            color: AppTheme.textColor,
            fontSize: 15,
          ),
          /*errorStyle: const TextStyle(
              overflow: TextOverflow.clip,
            ),*/
          contentPadding: const EdgeInsets.symmetric(vertical: 18,horizontal: 12),
          disabledBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: AppTheme.shadowColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: AppTheme.shadowColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color:AppTheme.shadowColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
              borderSide:
              const BorderSide(color: AppTheme.secondaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(8)),
        ),
        validator: widget.validator);
  }
}
