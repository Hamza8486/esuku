// To parse this JSON data, do
//
//     final leaveResponse = leaveResponseFromJson(jsonString);

import 'dart:convert';

LeaveResponse leaveResponseFromJson(String str) =>
    LeaveResponse.fromJson(json.decode(str));

String leaveResponseToJson(LeaveResponse data) => json.encode(data.toJson());

class LeaveResponse {
  LeaveResponse({
    required this.status,
    required this.leaves,
    required this.message,
  });

  bool status;
  List<Leaf> leaves;
  String message;

  factory LeaveResponse.fromJson(Map<String, dynamic> json) => LeaveResponse(
        status: json["status"],
        leaves: List<Leaf>.from(json["leaves"].map((x) => Leaf.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "leaves": List<dynamic>.from(leaves.map((x) => x.toJson())),
        "message": message,
      };
}

class Leaf {
  Leaf({
    required this.id,
    required this.studentId,
    required this.date,
    required this.type,
    required this.reason,
    required this.approved,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String studentId;
  String date;
  String type;
  String reason;
  String approved;
  DateTime createdAt;
  DateTime updatedAt;

  factory Leaf.fromJson(Map<String, dynamic> json) => Leaf(
        id: json["id"],
        studentId: json["student_id"] ?? "",
        date: json["date"] ?? "",
        type: json["type"] ?? "",
        reason: json["reason"] ?? "",
        approved: json["approved"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "date": date,
        "type": type,
        "reason": reason,
        "approved": approved,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
