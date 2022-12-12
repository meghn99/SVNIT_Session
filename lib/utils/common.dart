import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Colors.dart';


InputDecoration inputDecoration(BuildContext context, {String? hint, String? label, TextStyle? textStyle, Widget? prefix}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    hintStyle: textStyle ?? secondaryTextStyle(),
    labelStyle: textStyle ?? primaryTextStyle(),
    prefix: prefix,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultRadius),
      borderSide: BorderSide(width: 1.0, color: Colors.black38),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultRadius),
      borderSide: BorderSide(width: 1.0, color: Colors.black38),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultRadius),
      borderSide: BorderSide(color: primaryColor, width: 1.0),
    ),
    alignLabelWithHint: true,
  );
}