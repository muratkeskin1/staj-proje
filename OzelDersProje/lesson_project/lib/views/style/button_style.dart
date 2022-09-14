
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class buttonStyleClass {
  ButtonStyle buttonStyle({Color color = Colors.blue}) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        )));
  }
}