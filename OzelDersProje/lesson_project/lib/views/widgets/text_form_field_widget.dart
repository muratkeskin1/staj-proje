// ignore_for_file: prefer_initializing_formals, prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required TextEditingController controller,
    required this.data,
    this.labelText,
    required this.keyboardType,
  })  : controller = controller,
        super(key: key);

  final TextEditingController controller;
  final data;
  final labelText;
  final keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        labelText: labelText,
      ),
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) {
            return "registerErrorMessage".tr().toString();
          }
          if (keyboardType == TextInputType.emailAddress) {
            if (!value.contains("@")) {
              return "emailErrorMessage".tr().toString();
            }
          }
          if (keyboardType == TextInputType.phone) {
            if (value.length != 10) {
              return "phoneErrorMessage".tr().toString();
            }
          }
          if (keyboardType == TextInputType.visiblePassword) {
            if (value.length < 5) {
              return "passwordErrorMessage".tr().toString();
            }
          }
          if (keyboardType == TextInputType.number) {
            if (int.tryParse(value) == null) {
              return "numberErrorMessage".tr().toString();
            }
          }
        }
        return null;
      },
    );
  }
}
