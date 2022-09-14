// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lesson_project/models/course.dart';

abstract class ICourseService {
  void courseAdd(Course course);
  void courseClose(String courseId);
  Future<List<Course>> getCourseList();
  void registerCourse(String studentId, DocumentReference courseId);
  List<Course> getCourseListByFilterName(String name, List<Course> courseList);
  List<Course> getCourseListByFilterPrice(
      int lower, int upper, List<Course> courseList);
}

class CourseService implements ICourseService {
  CourseService();
  var db = FirebaseFirestore.instance;
  String collectionCourse = 'courses';
  String collectionStudent = 'students';

  @override
  Future<void> courseAdd(Course course) async {
    await db.collection(collectionCourse).add(course.toJson());
  }

  @override
  Future<void> courseClose(String courseId) async {
    await db
        .collection(collectionCourse)
        .doc(courseId)
        .update({"isClosed": false});
  }

  @override
  Future<void> registerCourse(
      String studentId, DocumentReference courseId) async {
    await db.collection(collectionStudent).doc(studentId).update({
      "courses": FieldValue.arrayUnion([courseId])
    });
  }

  @override
  Future<List<Course>> getCourseList() async {
    QuerySnapshot querySnapshot = await db.collection(collectionCourse).get();

    List<Course> courseList = [];
    querySnapshot.docs.map((e) {
      Course course = Course.fromJson(e.data() as Map<String, dynamic>);
      course.docId = e.id;
      courseList.add(course);
    }).toList();
    return courseList;
  }

  @override
  List<Course> getCourseListByFilterName(String name, List<Course> courseList) {
    return courseList
        .where((element) =>
            element.name!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  @override
  List<Course> getCourseListByFilterPrice(
      int lower, int upper, List<Course> courseList) {
    return courseList
        .where((element) => element.price! >= lower && element.price! <= upper)
        .toList();
  }
}
