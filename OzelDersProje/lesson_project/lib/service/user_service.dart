// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson_project/models/baseModelClass.dart';
import 'package:lesson_project/models/course.dart';
import 'package:lesson_project/models/student.dart';
import 'package:lesson_project/models/teacher.dart';

abstract class IUserService {
  void register(Teacher user);
  Future<bool> checkEmail(String email, String collection);
  String encryptPassword(String password);
  Future<BaseModelClass?> getUser(String? userId);
  Future<List<Course>> studentCourseHistory(String userId);
}

class UserService implements IUserService {
  UserService();
  var db = FirebaseFirestore.instance;
  /*Future<void> func(UserRole userRole) async {
    var user = await Teacher(
        "name", "surname", "phone", "email", "password", userRole,
        courseList: ["course1", "course2"]);
    register(user);
  }
*/
  @override
  Future<void> register(BaseModelClass user) async {
    var collection = '${user.userRole.name.toLowerCase()}s';
    print(collection);
    var result = await checkEmail(user.email, collection);
    if (result) {
      print(checkEmail(user.email, collection));
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      user.password = encryptPassword(user.password);
      await db.collection(collection).add(user.toJson());
    }
    else{
      throw FirebaseAuthException(code:'ERROR_EMAIL_ALREADY_IN_USE');
    }
  }

  @override
  Future<bool> checkEmail(String email, String collection) async {
    await db
        .collection(collection)
        .where("email", isEqualTo: email)
        .get()
        .then((value) {
      value.docs.map((doc) {
        if (doc.data().isEmpty) {
          return false;
        }
      }).toList();
    });
    return true;
  }

  @override
  String encryptPassword(String password) {
    final key = Key.fromLength(32);

    final encrypter = Encrypter(AES(key));
    final iv = IV.fromLength(16);
    return encrypter.encrypt(password, iv: iv).base64;
  }

  @override
  Future<BaseModelClass?> getUser(String? userId) async {
    var teacher = await db.collection("teachers").doc(userId).get();
    if (teacher.data() != null) {
      print("teacher");
      return Teacher.fromJson(teacher.data() as Map<String, dynamic>);
    }
    var student = await db.collection("students").doc(userId).get();
    if (student.data() != null) {
      print("student");
      return Student.fromJson(student.data() as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<List<Course>> studentCourseHistory(String userId) async {
    List<Course> courses = [];
    List<dynamic> docRefs = [];
    await db.collection("students").doc(userId).get().then((value) {
      if (value.exists) {
        docRefs = value.data()!["courses"];
      }
    });
    for (var element in docRefs) {
      await db.collection("courses").doc(element.id).get().then((value) {
        courses.add(Course.fromJson(value.data() as Map<String, dynamic>));
      });
    }
    return courses;
  }
}
