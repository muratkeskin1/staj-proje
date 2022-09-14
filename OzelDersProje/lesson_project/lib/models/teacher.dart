import 'package:lesson_project/models/baseModelClass.dart';

class Teacher extends BaseModelClass {
  List<String>? courseList;
  String? country;
  String? city;
  String? county;

  Teacher(super.name, super.surname, super.phone, super.email, super.password,
      super.userRole,
      {this.courseList, this.country, this.city, this.county});

  Teacher.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json['name'];
    surname = json['surname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    userRole = UserRole.values.byName(json['userRole']);
    if (json['Course'] != null) {
      courseList = <String>[];
      json['Course'].forEach((v) {
        courseList!.add(v.toString());
      });
    }
    country = json['country'];
    city = json['city'];
    county = json['county'];
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
    if (courseList != null) {
      data['Course'] = courseList!.map((v) => v.toString()).toList();
    }
    data['country'] = country;
    data['city'] = city;
    data['county'] = county;

    return data;
  }
}
