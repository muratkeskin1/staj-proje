// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, camel_case_types, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/views/screens/register_page.dart';
import 'package:lesson_project/views/widgets/appbar.dart';
import 'package:lesson_project/views/widgets/loading_modal.dart';
import 'package:lesson_project/views/widgets/text_field_widget.dart';
import '../../service/firebase_auth_service.dart';
import '../style/button_style.dart';
import 'homepage.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _resetEmailController =
      TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final LoginService loginService = LoginService();
  var data;
  var isLoading = false;
  @override
  void initState() {
    super.initState();
    /*ReadJsonMessages().readJson().then((value) {
      setState(() {
        data = value;
      });
    });*/
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('Login Page'.tr().toString()),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: textBuild(
                      border: true,
                      controller: _emailController,
                      labelText: 'Email'.tr().toString(),
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: textBuild(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      labelText: 'Password'.tr().toString(),
                      border: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            LoadingModal().showDialogModal(context);
                            try {
                              await loginService.login(_emailController.text,
                                  _passwordController.text);
                              LoadingModal().stopLoading(context);
                              await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => homepage()),
                                  (Route<dynamic> route) => false);
                            } catch (e) {
                              final snackBar = SnackBar(
                                content:
                                    Text("loginErrorMessage".tr().toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              LoadingModal().stopLoading(context);
                            }
                          },
                          style: buttonStyleClass().buttonStyle(),
                          icon: const Icon(Icons.login),
                          label: Text("Login".tr().toString()),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerPage()),
                            );
                          },
                          style: buttonStyleClass().buttonStyle(),
                          icon: const Icon(Icons.person_add),
                          label: Text("Register".tr().toString()),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Forgot Password".tr().toString()),
                            actions: [
                              Column(
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _resetEmailController,
                                    decoration: InputDecoration(
                                      labelText: "Email".tr().toString(),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),), ), ),
                                  Row(
                                    children: [
                                      TextButton(
                                        child: Text("Cancel".tr().toString()),
                                        onPressed: () {
                                          Navigator.of(context).pop();},),
                                      TextButton(
                                        style: buttonStyleClass().buttonStyle(
                                            color: Colors.green.shade300),
                                        onPressed: () async {
                                          if (_resetEmailController .text.isNotEmpty) {
                                            try {
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail( email:_resetEmailController.text);
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.SUCCES,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: 'Successful',
                                                desc:'Password reset email sent to ${_resetEmailController.text}',
                                                btnOkOnPress: () {
                                                  setState(() {_resetEmailController.clear();});
                                                  Navigator.of(context).pop();},).show();
                                            } on FirebaseAuthException catch (e) {
                                              switch (e.code) {
                                                case 'user-not-found':
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:DialogType.ERROR,
                                                    animType:AnimType.BOTTOMSLIDE,
                                                    title: 'invalid email'.tr().toString(),
                                                    btnOkOnPress: () {
                                                      Navigator.of(context).pop(); },).show();
                                                  break;}
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(e.toString()),)); }} else {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text("E posta boş olamaz"),  )); }},
                                        child: Text("Ok".tr().toString()),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Forgot Password'.tr().toString(),
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
