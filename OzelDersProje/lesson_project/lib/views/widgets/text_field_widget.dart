// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class textBuild extends StatelessWidget {
  const textBuild({
    Key? key,
    required this.keyboardType,
    required this.obscureText,
    required this.labelText,
    required this.border,
    required this.controller,
  }) : super(key: key);
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: border
            ? OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
            : null,
        labelText: labelText,
      ),
    );
  }
}
