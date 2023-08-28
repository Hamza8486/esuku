// To parse this JSON data, do
//
//     final feesResponse = feesResponseFromJson(jsonString);

import 'dart:convert';

FeesResponse feesResponseFromJson(String str) =>
    FeesResponse.fromJson(json.decode(str));

String feesResponseToJson(FeesResponse data) => json.encode(data.toJson());

class FeesResponse {
  FeesResponse({
    required this.status,
    required this.fees,
    required this.message,
  });

  bool status;
  List<Fee> fees;
  String message;

  factory FeesResponse.fromJson(Map<String, dynamic> json) => FeesResponse(
        status: json["status"],
        fees: List<Fee>.from(json["fees"].map((x) => Fee.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "fees": List<dynamic>.from(fees.map((x) => x.toJson())),
        "message": message,
      };
}

class Fee {
  Fee({
    required this.id,
    required this.schoolCode,
    required this.classId,
    required this.sectionId,
    required this.studentId,
    required this.amount,
    required this.status,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String schoolCode;
  String classId;
  String sectionId;
  String studentId;
  String amount;
  String status;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        id: json["id"],
        schoolCode: json["school_code"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        studentId: json["student_id"],
        amount: json["amount"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_code": schoolCode,
        "class_id": classId,
        "section_id": sectionId,
        "student_id": studentId,
        "amount": amount,
        "status": status,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
