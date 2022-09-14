
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBar(String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),

      ),
    ),
    elevation: 25,
    //backgroundColor: Colors.red,
  shadowColor: Colors.red,
  systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}