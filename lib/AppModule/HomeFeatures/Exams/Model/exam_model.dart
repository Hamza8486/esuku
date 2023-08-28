// To parse this JSON data, do
//
//     final examResponse = examResponseFromJson(jsonString);

import 'dart:convert';

ExamResponse examResponseFromJson(String str) =>
    ExamResponse.fromJson(json.decode(str));

String examResponseToJson(ExamResponse data) => json.encode(data.toJson());

class ExamResponse {
  ExamResponse({
    required this.status,
    required this.exams,
    required this.message,
  });

  bool status;
  List<Exam> exams;
  String message;

  factory ExamResponse.fromJson(Map<String, dynamic> json) => ExamResponse(
        status: json["status"],
        exams: List<Exam>.from(json["exams"].map((x) => Exam.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "exams": List<dynamic>.from(exams.map((x) => x.toJson())),
        "message": message,
      };
}

class Exam {
  Exam({
    required this.id,
    required this.schoolCode,
    required this.title,
    required this.classId,
    required this.sectionId,
    required this.subjectId,
    required this.date,
    required this.startHour,
    required this.endHour,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
    required this.marks,
  });

  int id;
  String schoolCode;
  String title;
  String classId;
  String sectionId;
  String subjectId;
  DateTime date;
  String startHour;
  String endHour;
  String comments;
  DateTime createdAt;
  DateTime updatedAt;
  Subject subject;
  List<dynamic> marks;

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        schoolCode: json["school_code"],
        title: json["title"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        subjectId: json["subject_id"],
        date: DateTime.parse(json["date"]),
        startHour: json["start_hour"],
        endHour: json["end_hour"],
        comments: json["comments"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subject: Subject.fromJson(json["subject"]),
        marks: List<dynamic>.from(json["marks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_code": schoolCode,
        "title": title,
        "class_id": classId,
        "section_id": sectionId,
        "subject_id": subjectId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_hour": startHour,
        "end_hour": endHour,
        "comments": comments,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subject": subject.toJson(),
        "marks": List<dynamic>.from(marks.map((x) => x)),
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
