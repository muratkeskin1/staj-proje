import 'package:lesson_project/models/baseModelClass.dart';

class Student extends BaseModelClass {
  Student(
    super.name,
    super.surname,
    super.phone,
    super.email,
    super.password,
    super.userRole,
  );

  Student.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json['name'];
    surname = json['surname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    userRole = UserRole.values.byName(json['userRole']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['userRole'] = userRole.name;

    return data;
  }
}
