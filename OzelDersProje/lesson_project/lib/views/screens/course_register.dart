// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, avoid_print, depend_on_referenced_packages

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/models/course.dart';
import 'package:lesson_project/service/course_service.dart';
import 'package:lesson_project/views/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class courseRegister extends StatefulWidget {
  courseRegister({Key? key}) : super(key: key);

  @override
  State<courseRegister> createState() => _courseRegisterState();
}

class _courseRegisterState extends State<courseRegister> {
  List<Course>? courses;
  final TextEditingController _lowerController = TextEditingController();
  final TextEditingController _upperController = TextEditingController();
  final TextEditingController _serachController = TextEditingController();
  Future<void> fetchList() async {
    await CourseService().getCourseList().then((value) {
      setState(() {
        courses = value;
        courseTempList = courses;
        _loading = false;
      });
    });
  }

  SharedPreferences? preferences;
  Future<void> setCache() async {
    preferences = await SharedPreferences.getInstance();
  }

  List<Course>? courseTempList;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    setCache();
    fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Course Register".tr().toString()),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Search".tr().toString(),
                            icon: const Icon(Icons.search),),
                          onChanged: (value) {
                            setState(() {
                              if (TextEditingController().text.isEmpty) {
                                courseTempList = courses; }
                              courseTempList = CourseService()
                                  .getCourseListByFilterName(
                                      value, courseTempList!); });},),),
                      IconButton(
                          onPressed: () {
                            filterDialog(context).show();},
                          icon: const Icon(Icons.filter_list)),
                      TextButton(
                          onPressed: () {
                            courseTempList = courses;
                            setState(() {
                              _serachController.text = "";
                              _lowerController.text = "";
                              _upperController.text = "";
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "filters have been reset".tr().toString()), ));});},
                          child: Text("Reset Filter".tr().toString()))
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(courseTempList![index].name.toString()),
                            subtitle: Text(
                                "Açıklama: ${courseTempList![index].description} Ücreti: ${courseTempList![index].price}"),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            tileColor: Colors.amber.shade300,
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.WARNING,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Register Course'.tr().toString(),
                                btnOkText: 'Register'.tr().toString(),
                                btnCancelText: "Back".tr().toString(),
                                useRootNavigator: true,
                                dismissOnTouchOutside: false,
                                desc:
                                    "${courses![index].description} ${courses![index].price}",
                                btnCancelOnPress: () {
                                  print('Back'.tr().toString());
                                },
                                btnOkOnPress: () {
                                  CourseService().registerCourse(
                                      preferences!.getString("id").toString(),
                                      FirebaseFirestore.instance.doc(
                                          "courses/${courses![index].docId}"));
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Register Course'.tr().toString(),
                                    desc: 'Register Success'.tr().toString(),
                                    btnOkText: 'OK'.tr().toString(),
                                    useRootNavigator: true,
                                    btnOkOnPress: () {},
                                  ).show();
                                },
                              ).show();
                            },
                          ),
                        );
                      },
                      itemCount: courseTempList!.length),
                ),
              ],
            ),
    );
  }

  AwesomeDialog filterDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Price Filter'.tr().toString(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: TextField(
                  onTap: () {
                    courseTempList = courses; },
                  controller: _serachController,
                  decoration: InputDecoration(
                    labelText: "Search".tr().toString(),),), ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextFormField(
                      controller: _lowerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lower".tr().toString(),),),),
                  const SizedBox(
                      width: 30,
                      child: Icon(
                        Icons.filter_alt,
                        color: Colors.red, )),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextFormField(
                      controller: _upperController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Upper".tr().toString(),),),),],),],),),),
      btnCancelOnPress: () {},
      btnOkOnPress: filterMethod,
    );
  }

  void filterMethod() {
    if (_serachController.text.isNotEmpty) {
      setState(() {
        courseTempList = CourseService()
            .getCourseListByFilterName(_serachController.text, courses!);
      });
    } else if ((int.tryParse(_lowerController.text) == null ||
        int.tryParse(_upperController.text) == null)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("invalid"),
        duration: Duration(seconds: 2),
      ));
    }
    if ((int.tryParse(_lowerController.text) != null ||
        int.tryParse(_upperController.text) != null)) {
      if ((int.tryParse(_lowerController.text)! >
          int.tryParse(_upperController.text)!)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Lower value must be smaller than upper value"),
          duration: Duration(seconds: 2),
        ));
      } else {
        setState(() {
          if (_serachController.text.isEmpty) {
            courseTempList = courses;
          }
          courseTempList = CourseService()
              .getCourseListByFilterName(_serachController.text, courses!);
          courseTempList = CourseService().getCourseListByFilterPrice(
              int.tryParse(_lowerController.text)!,
              int.tryParse(_upperController.text)!,
              courseTempList!);
        });
      }
    }
  }
}
