// ignore_for_file: file_names, constant_identifier_names


 class BaseModelClass {
  late String name;
  late String surname;
  late String phone;
  late String email;
  late String password;
  late UserRole userRole;

  BaseModelClass(this.name, this.surname, this.phone, this.email, this.password,
      this.userRole);


  BaseModelClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    userRole =  UserRole.values.byName(json['userRole']);
  }

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

enum UserRole { Student, Teacher }
