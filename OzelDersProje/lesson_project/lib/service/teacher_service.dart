import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lesson_project/models/course.dart';

abstract class ITeacherService {
  void courseAdd(Course course);
}

class TeacherService implements ITeacherService {
  TeacherService();
  var db = FirebaseFirestore.instance;

  @override
  Future<void> courseAdd(Course course) async {
    await db.collection("courses").add(course.toJson());
  }
}
