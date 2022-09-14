// ignore_for_file: unused_local_variable, avoid_print, depend_on_referenced_packages

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ILoginService {
  void login(String email, String password);
  void create(String email, String password);
  void logout();
}

class LoginService implements ILoginService {
  SharedPreferences? preferences;
  Future<void> initCache() async {
    preferences = await SharedPreferences.getInstance();
  }

  LoginService();
  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  @override
  Future<void> login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    await setCacheId(email, password);
  }

  FutureOr<bool> setCacheId(String email, String password) async {
    await initCache();
    await db
        .collection("teachers")
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get()
        .then((value) {
      value.docs.map((doc) async {
        if (doc.data().isNotEmpty) {
          await preferences!.setString("id", doc.id);
          await preferences!.setString("userRole", doc.data()["userRole"]);
          return true;
        }
      }).toList();
    });
    await db
        .collection("students")
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get()
        .then((value) {
      value.docs.map((doc) async {
        if (doc.data().isNotEmpty) {
          await preferences!.setString("id", doc.id);
          await preferences!.setString("userRole", doc.data()["userRole"]);
          return true;
        }
      }).toList();
    });
    return false;
  }

  @override
  void create(String email, String password) {}

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  void registerCourse(String? string, String s) {}
}
