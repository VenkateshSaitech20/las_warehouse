// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:las_warehouse/app/data/my_colors.dart';

class TextFieldThem {
  const TextFieldThem(Key? key);

  static buildTextField({
    required String title,
    required TextEditingController controller,
    IconData? icon,
    Widget? suffixWidget,
    String? Function(String?)? validators,
    TextInputType textInputType = TextInputType.text,
    obscure,
    EdgeInsets contentPadding = EdgeInsets.zero,
    autoFocus,
    maxLine,
    enabled,
    maxLength,
    String? labelText,
    AutovalidateMode? autovalidateMode,
    TextStyle? hintStyle,
    void Function(String?)? onChanged,
    inputFormatter,
  }) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      style: TextStyle(
        fontSize: 14,
        color: MyColors.grey_5,
        letterSpacing: 1.0,
      ),
      autofocus: autoFocus,
      obscureText: obscure,
      validator: validators,
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLine,
      maxLength: maxLength,
      enabled: enabled,
      decoration: InputDecoration(
        errorMaxLines: 8,
        counterText: "",
        labelText: labelText,
        hintText: title,
        hintStyle: hintStyle,
        contentPadding: contentPadding,
        suffixIcon: suffixWidget,
        border: const UnderlineInputBorder(),
      ),
      onSaved: (value) {},
      inputFormatters: inputFormatter,
    );
  }

  static boxBuildTextField({
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validators,
    TextInputType textInputType = TextInputType.text,
    TextAlign textAlign = TextAlign.start,
    bool obscureText = true,
    EdgeInsets contentPadding = EdgeInsets.zero,
    autoFocus = true,
    obscure = false,
    maxLine = 1,
    bool enabled = true,
    maxLength = 300,
    String? labelText,
    TextStyle? hintStyle,
    Widget? suffixWidget,
    Widget? prefixWidget,
    AutovalidateMode? autovalidateMode,
    OutlineInputBorder? border,
    inputFormatter,
  }) {
    return TextFormField(
      textAlign: textAlign,
      autovalidateMode: autovalidateMode,
      autofocus: autoFocus,
      obscureText: obscure,
      validator: validators,
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      maxLines: maxLine,
      maxLength: maxLength,
      enabled: enabled,
      onSaved: (value) {},
      decoration: InputDecoration(
        errorMaxLines: 9,
        suffixIcon: suffixWidget,
        prefixIcon: prefixWidget,
        counterText: "",
        contentPadding: contentPadding,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryblue, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.grey, width: 0.7),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryred, width: 0.7),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.grey, width: 0.7),
        ),
        hintText: hintText,
        hintStyle: hintStyle,
      ),
      inputFormatters: inputFormatter,
    );
  }

  static buildTextFieldTheme({
    void Function()? onTap,
    TextEditingController? controller,
    String? initialValue,
    //FocusNode? focusNode,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool? readOnly,
    bool? showCursor,
    String obscuringCharacter = '*',
    bool? obscureText,
    bool? autocorrect,
    int? maxLines,
    int? minLines,
    bool? expands,
    int? maxLength,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
    void Function(String)? onFieldSubmitted,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    AutovalidateMode? autovalidateMode,
    bool? autofocus,
    int? errorMaxLines,
    String? counterText,
    String? labelText,
    String? hintText,
    dynamic hintStyle,
    EdgeInsetsGeometry? contentPadding,
    Widget? suffixIcon,
    InputBorder? border,
  }) {
    return TextFormField(
      onTap: onTap,
      autovalidateMode: autovalidateMode,
      style: style,
      autofocus: autofocus!,
      obscureText: obscureText!,
      validator: validator,
      keyboardType: keyboardType!,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      decoration: decoration,
      onSaved: (value) {},
      inputFormatters: inputFormatters,
      readOnly: readOnly!,
    );
  }

  static boxBuildTextFieldtheme({
    TextEditingController? controller,
    String? initialValue,
    InputDecoration? decoration,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    bool? autofocus,
    bool? readOnly,
    String obscuringCharacter = '*',
    bool? obscureText,
    bool? autocorrect,
    int? maxLines,
    int? minLines,
    bool? expands,
    int? maxLength,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
    void Function(String)? onFieldSubmitted,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    AutovalidateMode? autovalidateMode,
    String? hintText,
    EdgeInsets? contentpadding,
    String? labelText,
    TextStyle? hintStyle,
    Widget? suffixWidget,
    Widget? prefixWidget,
    TextInputType? keyboardType,
    OutlineInputBorder? border,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      minLines: maxLines,
      textAlign: textAlign!,
      autovalidateMode: autovalidateMode,
      autofocus: autofocus!,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: textInputAction,
      textDirection: textDirection,
      textAlignVertical: textAlignVertical,
      readOnly: readOnly!,
      autocorrect: autocorrect!,
      style: style,
      strutStyle: strutStyle,
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      decoration: InputDecoration(
        suffixIcon: suffixWidget,
        prefixIcon: prefixWidget,
        counterText: "",
        contentPadding: contentpadding,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryblue, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.grey, width: 0.7),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryred, width: 0.7),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.grey, width: 0.7),
        ),
        hintText: hintText,
        hintStyle: hintStyle,
      ),
    );
  }
}
