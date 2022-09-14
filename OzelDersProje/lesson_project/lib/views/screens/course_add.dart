// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/models/course.dart';
import 'package:lesson_project/service/course_service.dart';
import 'package:lesson_project/views/widgets/appbar.dart';
import 'package:lesson_project/views/widgets/text_form_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../service/json_read.dart';
import 'package:sizer/sizer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class courseAdd extends StatefulWidget {
  courseAdd({Key? key}) : super(key: key);

  @override
  State<courseAdd> createState() => _courseAddState();
}

class _courseAddState extends State<courseAdd> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FToast fToast;
  var item = ['Level', 'Beginner', 'Intermediate', 'Advanced'];
  String dropdownvalue = "Level";
  var data;

  SharedPreferences? preferences;
  Future<void> setCache() async {
    preferences = await SharedPreferences.getInstance();
  }

  //init state
  @override
  void initState() {
    setCache();
    ReadJsonMessages().readJson().then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('Add Course'.tr().toString()),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 8.h,
                          width: 45.w,
                          child: TextFormFieldWidget(
                              controller: _courseNameController,
                              data: data,
                              keyboardType: TextInputType.text,
                              labelText: "Course Name".tr().toString()),
                        ),
                        SizedBox(
                          height: 8.h,
                          width: 45.w,
                          child: TextFormFieldWidget(
                              controller: _priceController,
                              data: data,
                              keyboardType: TextInputType.number,
                              labelText: "Price".tr().toString()),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    maxLines: 2,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: "Description".tr().toString(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "registerErrorMessage".tr().toString();
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: _dateTimeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "DateTime".tr().toString(),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2023));
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate!);
                        setState(() {
                          _dateTimeController.text = formattedDate;
                        });
                      },
                      validator: (value) {
                        String dateTimeNow =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        if (value!.isEmpty) {
                          return 'dateTimeErrorMessage'.tr().toString();
                        }
                        if (DateTime.parse(value).isBefore(
                                DateFormat('yyyy-MM-dd').parse(dateTimeNow)) ||
                            DateTime.parse(value).isAtSameMomentAs(
                                DateFormat('yyyy-MM-dd').parse(dateTimeNow))) {
                          return 'afterTodayErrorMessage'.tr().toString();
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 10.h,
                          width: 30.w,
                          child: TextFormFieldWidget(
                              controller: _hourController,
                              data: data,
                              keyboardType: TextInputType.number,
                              labelText: "hour length".tr().toString()),
                        ),
                        SizedBox(
                            height: 10.h,
                            width: 50.w,
                            child: DropdownButtonFormField(
                              value: dropdownvalue,
                              items: item.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == "Level") {
                                  return 'levelSelectErrorMessage'
                                      .tr()
                                      .toString();
                                }
                                return null;
                              },
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              },
                            ))
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print("valid");
                          var docRef = FirebaseFirestore.instance
                              .collection('teachers')
                              .doc(preferences!.getString('id'));
                          var course = Course(
                              name: _courseNameController.text,
                              price: int.parse(_priceController.text),
                              level: Level.values.byName(dropdownvalue),
                              description: _descriptionController.text,
                              date: _dateTimeController.text,
                              hour: int.parse(_hourController.text),
                              teacherDocPathId: docRef);
                          print("object");
                          await CourseService().courseAdd(course);
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Success',
                              desc: 'Course Added Successfully',
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              }).show();
                        } else {
                          print("invalid");
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add Course".tr().toString())),
                ],
              ),
            ),
          ),
        ));
  }
}
