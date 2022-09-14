// ignore_for_file: camel_case_types, depend_on_referenced_packages, prefer_const_constructors_in_immutables, avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/models/course.dart';
import 'package:lesson_project/service/user_service.dart';
import 'package:lesson_project/views/widgets/loading_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/appbar.dart';

class courseHistory extends StatefulWidget {
  courseHistory({Key? key}) : super(key: key);

  @override
  State<courseHistory> createState() => _courseHistoryState();
}

class _courseHistoryState extends State<courseHistory> {
  List<Course>? courses;
  bool _loading = true;
  Future<void> fetchList() async {
    await UserService()
        .studentCourseHistory(preferences!.getString("id").toString())
        .then((value) {
      setState(() {
        courses = value;
        print(courses);
        _loading = false;
      });
    });
  }

  SharedPreferences? preferences;
  Future<void> setCache() async {
    preferences = await SharedPreferences.getInstance();
    await fetchList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setCache();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('Course History'.tr().toString()),
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : Center(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(courses![index].name.toString()),
                      subtitle: Text(courses![index].date.toString()),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "${courses![index].description} ${courses![index].price}"),
                        ));
                      },
                    );
                  },
                  itemCount: courses!.length,
                ),
              ));
  }

  Future loadingModal(BuildContext context) {
    return LoadingModal().showDialogModal(context);
  }

  void stopLoadingModal(BuildContext context) {
    LoadingModal().stopLoading(context);
  }
}
