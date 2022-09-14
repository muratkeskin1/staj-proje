// ignore_for_file: use_build_context_synchronously, camel_case_types, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/views/screens/course_add.dart';
import 'package:lesson_project/views/screens/course_history.dart';
import 'package:lesson_project/views/screens/course_register.dart';
import 'package:lesson_project/views/screens/profile.dart';
import 'package:lesson_project/views/widgets/appbar.dart';
import 'package:lesson_project/views/widgets/homepage_drawer.dart';

class homepage extends StatefulWidget {
  homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {


  var _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Home Page'.tr().toString()),
      drawer: drawrerWidget(),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.red,
          unselectedItemColor: Colors.amber.shade400,
          type: BottomNavigationBarType.shifting,
          currentIndex: _index,
          onTap: (value) {
            if (value == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return homepage();
              }));
            }
            if (value == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return profilePage();
              }));
            }
            setState(() {
              _index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home".tr().toString(),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Profile".tr().toString(),
              icon: Icon(Icons.account_circle),
            ),
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: Colors.blue,
                        leading: Icon(Icons.school_outlined),
                        title: Text(
                          'Course History'.tr().toString(),
                        ),
                        subtitle: Text('Course History'.tr().toString()),
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => courseHistory()));
                        }),
                      )
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: Colors.green,
                        leading: Icon(Icons.school_outlined),
                        title: Text('Create New Course'.tr().toString()),
                        subtitle: Text('Create New Course'.tr().toString()),
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => courseAdd()));
                        }),
                      )
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: Colors.red,
                        leading: Icon(Icons.school_outlined),
                        title: Text('Course Register'.tr().toString()),
                        subtitle: Text('Course Register'.tr().toString()),
                        onTap: (() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return courseRegister();
                          }));
                        }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
