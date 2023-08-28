// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.message,
    required this.token,
  });

  bool status;
  String message;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}

class School {
  School({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String code;
  String name;
  String address;
  String city;
  String country;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
        phone: json["phone"],
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Section {
  Section({
    required this.id,
    required this.classId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String classId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

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

class Class {
  Class({
    required this.id,
    required this.schoolCode,
    required this.classCode,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String schoolCode;
  String classCode;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        schoolCode: json["school_code"],
        classCode: json["class_code"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_code": schoolCode,
        "class_code": classCode,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
