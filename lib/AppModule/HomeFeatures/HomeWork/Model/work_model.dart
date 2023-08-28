// To parse this JSON data, do
//
//     final homeWorkResponse = homeWorkResponseFromJson(jsonString);

import 'dart:convert';

HomeWorkResponse homeWorkResponseFromJson(String str) => HomeWorkResponse.fromJson(json.decode(str));

String homeWorkResponseToJson(HomeWorkResponse data) => json.encode(data.toJson());

class HomeWorkResponse {
  HomeWorkResponse({
    required this.status,
    required this.todayHomework,
    required this.homework,
    required this.message,
  });

  bool status;
  List<Homework> todayHomework;
  List<Homework> homework;
  String message;

  factory HomeWorkResponse.fromJson(Map<String, dynamic> json) => HomeWorkResponse(
    status: json["status"],
    todayHomework: List<Homework>.from(json["todayHomework"].map((x) => Homework.fromJson(x))),
    homework: List<Homework>.from(json["homework"].map((x) => Homework.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "todayHomework": List<dynamic>.from(todayHomework.map((x) => x.toJson())),
    "homework": List<dynamic>.from(homework.map((x) => x.toJson())),
    "message": message,
  };
}

class Homework {
  Homework({
    required this.id,
    required this.schoolCode,
    required this.classId,
    required this.sectionId,
    required this.subjectId,
    required this.homework,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
  });

  int id;
  String schoolCode;
  String classId;
  String sectionId;
  String subjectId;
  String homework;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;
  Subject subject;

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
    id: json["id"],
    schoolCode: json["school_code"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    subjectId: json["subject_id"],
    homework: json["homework"],
    date: DateTime.parse(json["date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    subject: Subject.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "school_code": schoolCode,
    "class_id": classId,
    "section_id": sectionId,
    "subject_id": subjectId,
    "homework": homework,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "subject": subject.toJson(),
  };
}

class Subject {
  Subject({
    required this.id,
    required this.schoolCode,
    required this.subjectCode,
    required this.name,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String schoolCode;
  String subjectCode;
  String name;
  String classId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    schoolCode: json["school_code"],
    subjectCode: json["subject_code"],
    name: json["name"],
    classId: json["class_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "school_code": schoolCode,
    "subject_code": subjectCode,
    "name": name,
    "class_id": classId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
