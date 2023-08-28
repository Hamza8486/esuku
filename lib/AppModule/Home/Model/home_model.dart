// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  bool ? status;
  HomeModel ? home;
  String ? message;

  HomeResponse({
    this.status,
    this.home,
    this.message,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    status: json["status"],
    home: HomeModel.fromJson(json["home"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "home": home!.toJson(),
    "message": message,
  };
}

class HomeModel {
  int  ? id;
  String ? userId;
  String ? schoolCode;
  String ? classId;
  String ? sectionId;
  String ? rollNumber;
  String ? firstName;
  String ? lastName;
  String ? gender;

  String  ? address;
  String  ? city;
  String ? phone;
  String ? email;
  String ? username;
  String ? password;
  String ? parentUsername;
  String ? parentPassword;
  dynamic image;
  String ? createdAt;
  String ? updatedAt;
  School ? school;
  Class ? homeClass;
  Section ? section;

  HomeModel({
    this.id,
    this.userId,
    this.schoolCode,
    this.classId,
    this.sectionId,
    this.rollNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.address,
    this.city,
    this.phone,
    this.email,
    this.username,
    this.password,
    this.parentUsername,
    this.parentPassword,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.school,
    this.homeClass,
    this.section,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    id: json["id"],
    userId: json["user_id"],
    schoolCode: json["school_code"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    rollNumber: json["roll_number"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    address: json["address"],
    city: json["city"],
    phone: json["phone"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    parentUsername: json["parent_username"],
    parentPassword: json["parent_password"],
    image: json["image"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    school: School.fromJson(json["school"]),
    homeClass: Class.fromJson(json["class"]),
    section: Section.fromJson(json["section"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "school_code": schoolCode,
    "class_id": classId,
    "section_id": sectionId,
    "roll_number": rollNumber,
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "address": address,
    "city": city,
    "phone": phone,
    "email": email,
    "username": username,
    "password": password,
    "parent_username": parentUsername,
    "parent_password": parentPassword,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "school": school!.toJson(),
    "class": homeClass!.toJson(),
    "section": section!.toJson(),
  };
}

class Class {
  int ?  id;
  String ? schoolCode;
  String ? classCode;
  String ? name;
  String ? createdAt;
  String ? updatedAt;

  Class({
    this.id,
    this.schoolCode,
    this.classCode,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    id: json["id"],
    schoolCode: json["school_code"],
    classCode: json["class_code"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "school_code": schoolCode,
    "class_code": classCode,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class School {
  int ? id;
  String  ? code;
  String ? name;
  String  ? address;
  String ? city;
  String  ? country;
  String ? phone;
  String  ? image;
  DateTime createdAt;
  DateTime updatedAt;

  School({
    this.id,
    this.code,
    this.name,
    this.address,
    this.city,
    this.country,
    this.phone,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    phone: json["phone"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "address": address,
    "city": city,
    "country": country,
    "phone": phone,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Section {
  int id;
  String classId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Section({
    required this.id,
    required this.classId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    classId: json["class_id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_id": classId,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
