// ignore_for_file: use_build_context_synchronously, camel_case_types, depend_on_referenced_packages

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/views/screens/homepage.dart';
import 'package:lesson_project/views/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/firebase_auth_service.dart';
import '../screens/login_page.dart';

class drawrerWidget extends StatelessWidget {
  const drawrerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.picsum.photos/id/744/200/200.jpg?hmac=8T0b9ya-1hs9mQn1Sosud4eldJZ6haGcupAiLTJHe2o'),
                fit: BoxFit.cover,
              ),
              color: Colors.blue,
            ),
            child: Text(''),
          ),
          ListTile(
            title: Text('Home Page'.tr().toString()),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return homepage();
              }));
            },
          ),
          ListTile(
            title: Text('Profile'.tr().toString()),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return profilePage();
              }));
            },
          ),
          ListTile(
            title: Text('Logout'.tr().toString()),
            onTap: () async {
              await SharedPreferences.getInstance().then((prefs) {
                prefs.clear();
              });
              await LoginService().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => loginPage()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
