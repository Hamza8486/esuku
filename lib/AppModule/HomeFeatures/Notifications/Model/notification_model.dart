// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    required this.status,
    required this.notifications,
    required this.message,
  });

  bool status;
  List<Notification> notifications;
  String message;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        status: json["status"],
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "message": message,
      };
}

class Notification {
  Notification({
    required this.id,
    required this.schoolCode,
    required this.classId,
    required this.sectionId,
    this.studentId,
    required this.notification,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String schoolCode;
  String classId;
  String sectionId;
  dynamic studentId;
  String notification;
  String read;
  DateTime createdAt;
  DateTime updatedAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        schoolCode: json["school_code"] ?? "",
        classId: json["class_id"] ?? "",
        sectionId: json["section_id"] ?? "",
        studentId: json["student_id"],
        notification: json["notification"] ?? "",
        read: json["read"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_code": schoolCode,
        "class_id": classId ,
        "section_id": sectionId ,
        "student_id": studentId,
        "notification": notification,
        "read": read,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
