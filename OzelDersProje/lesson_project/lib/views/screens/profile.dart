// ignore_for_file: avoid_print, prefer_const_constructors_in_immutables, depend_on_referenced_packages, camel_case_types, duplicate_ignore

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/models/baseModelClass.dart';
import 'package:lesson_project/service/user_service.dart';
import 'package:lesson_project/views/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilePage extends StatefulWidget {
  profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  SharedPreferences? preferences;
  BaseModelClass? user;
  bool _loading = true;
  Future<void> setCache() async {
    preferences = await SharedPreferences.getInstance();
    print(preferences!.getString("id"));
    user = await UserService().getUser(preferences!.getString('id'));
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
  
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setCache(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("Profile".tr().toString()),
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Image.network("https://picsum.photos/200")),
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Name".tr().toString(),
                      ),
                      controller: TextEditingController(text: user?.name),
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Surname".tr().toString(),
                      ),
                      controller: TextEditingController(text: user?.surname),
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Email".tr().toString(),
                      ),
                      controller: TextEditingController(text: user?.email),),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Phone".tr().toString(),),
                      controller: TextEditingController(text: user?.phone),
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "UserRole".tr().toString(),
                      ),
                      controller: TextEditingController(
                          text: user?.userRole.name.tr().toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    EasyLocalization.of(context)!
                                        .setLocale(const Locale('tr'));
                                  });
                                },
                                child: const Text(
                                  "tr",
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    EasyLocalization.of(context)!
                                        .setLocale(const Locale('en'));
                                  });
                                },
                                child: const Text(
                                  "en",
                                )),
                          ]),
                    )
                  ],
                ),
              ));
  }
}
