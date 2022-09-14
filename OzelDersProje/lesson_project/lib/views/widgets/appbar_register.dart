// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBarRegister(String title, BuildContext context) {
  final TextEditingController lowerController = TextEditingController();
  final TextEditingController upperController = TextEditingController();
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            body: SingleChildScrollView(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: TextFormField(
                        controller: lowerController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Lower",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: TextFormField(
                        controller: upperController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Upper",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            btnCancelOnPress: () {
              print('Cancel is pressed');
            },
            btnOkOnPress: () {
              print('OK is pressed');
              if (lowerController.text.isEmpty ||
                  upperController.text.isEmpty) {
                print("empty");
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please fill all fields"),
                  duration: Duration(seconds: 2),
                ));
              } else if (int.tryParse(lowerController.text) == null ||
                  int.tryParse(upperController.text) == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Cast Error"),
                  duration: Duration(seconds: 2),
                ));
              } else if (int.tryParse(lowerController.text)! >
                  int.tryParse(upperController.text)!) {
                print("cast error");
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Lower value must be smaller than upper value"),
                  duration: Duration(seconds: 2),
                ));
              } else {
                print(upperController.text);
                print(lowerController.text);
              }
            },
          ).show();
        },
      ),
    ],
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
