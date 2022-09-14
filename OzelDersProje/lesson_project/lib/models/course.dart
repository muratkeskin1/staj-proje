// ignore_for_file: constant_identifier_names, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String? docId;
  String? name;
  int? price;
  bool? isClosed;
  Level? level;
  String? country;
  String? city;
  String? county;
  String? date;
  String? description;
  int? hour;
  //Teacher? teacher;
  //teacher reference
  DocumentReference? teacherDocPathId;

  Course(
      {this.docId = '',
      this.name,
      this.price,
      this.isClosed = false,
      this.level,
      this.country,
      this.city,
      this.county,
      this.date,
      this.hour,
      this.description,
      this.teacherDocPathId});

  Course.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    isClosed = json['isClosed'];
  
    level = Level.values.byName(json['level']);
    country = json['country'] ?? ' ';
    city = json['city'] ?? ' ';
    county = json['county'] ?? ' ';
    date = json['date'];
    description = json['description'];
    hour = json['hour'];
    teacherDocPathId = json['teacherDocPathId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = this.name;
    data['price'] = this.price;
    data['isClosed'] = this.isClosed;
    data['level'] = this.level!.name;
    data['country'] = this.country ?? '';
    data['city'] = this.city ?? '';
    data['county'] = this.county ?? '';
    data['date'] = this.date;
    data['description'] = this.description;
    data['hour'] = this.hour;
    data['teacherDocPathId'] = this.teacherDocPathId;
    return data;
  }
}

enum Level {
  Beginner,
  Intermediate,
  Advanced,
}
