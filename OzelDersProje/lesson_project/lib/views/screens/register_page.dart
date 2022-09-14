// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, camel_case_types, prefer_initializing_formals, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/models/baseModelClass.dart';
import 'package:lesson_project/service/json_read.dart';
import 'package:lesson_project/service/user_service.dart';
import 'package:lesson_project/views/style/button_style.dart';
import 'package:lesson_project/views/widgets/appbar.dart';
import 'package:lesson_project/views/widgets/loading_modal.dart';
import 'package:lesson_project/views/widgets/text_form_field_widget.dart';

class registerPage extends StatefulWidget {
  registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
//controllers
  late final TextEditingController _firstNameController =
      TextEditingController();
  late final TextEditingController _lastNameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _phoneNumberController =
      TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  String dropdownvalue = 'Role';
  final _formKey = GlobalKey<FormState>();

  var items = ['Role', 'Student', 'Teacher'];

  var data;
  //init state
  @override
  void initState() {
    ReadJsonMessages().readJson().then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Register Page'.tr().toString()),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text("Create Your Account".tr().toString()),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormFieldWidget(
                          controller: _firstNameController,
                          data: data,
                          labelText: "First Name".tr().toString(),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormFieldWidget(
                          controller: _lastNameController,
                          data: data,
                          labelText: "Last Name".tr().toString(),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    controller: _emailController,
                    data: data,
                    labelText: "Email".tr().toString(),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    controller: _phoneNumberController,
                    data: data,
                    labelText: "Phone Number".tr().toString(),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    controller: _passwordController,
                    data: data,
                    labelText: "Create Your Password".tr().toString(),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    width: 90,
                    child: dropDownButtonFormFieldWidget(),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            LoadingModal().showDialogModal(context);
                            await UserService().register(BaseModelClass(
                              _firstNameController.text,
                              _lastNameController.text,
                              _phoneNumberController.text,
                              _emailController.text,
                              _passwordController.text,
                              UserRole.values.byName(dropdownvalue),
                            ));
                            LoadingModal().stopLoading(context);
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Success',
                                desc:
                                    'Your account has been created successfully',
                                btnOkOnPress: () {
                                  Navigator.pop(context);
                                }).show();
                          } catch (e) {
                            LoadingModal().showDialogModal(context);
                            final snackBar = SnackBar(
                              content: Text("invalidRegisterErrorMessage"
                                  .tr()
                                  .toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            LoadingModal().stopLoading(context);
                          }
                        }
                      },
                      style: buttonStyleClass().buttonStyle(
                          color: Color.fromARGB(230, 16, 174, 179)),
                      child: Text(
                        "Sign Up".tr().toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.white),
                      )),
                ],
              ),
            )),
      ),
    );
  }

  DropdownButtonFormField<String> dropDownButtonFormFieldWidget() {
    return DropdownButtonFormField(
      value: dropdownvalue,
      items: items.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == 'Role') {
          return "roleSelectErrorMessage".tr().toString();
        }
        return null;
      },
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }
}
