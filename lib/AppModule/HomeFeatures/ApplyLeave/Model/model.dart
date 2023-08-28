// To parse this JSON data, do
//
//     final applyLeaveResponse = applyLeaveResponseFromJson(jsonString);

import 'dart:convert';

ApplyLeaveResponse applyLeaveResponseFromJson(String str) =>
    ApplyLeaveResponse.fromJson(json.decode(str));

String applyLeaveResponseToJson(ApplyLeaveResponse data) =>
    json.encode(data.toJson());

class ApplyLeaveResponse {
  ApplyLeaveResponse({
    required this.status,
    required this.message,
  });

  bool status;

  String message;

  factory ApplyLeaveResponse.fromJson(Map<String, dynamic> json) =>
      ApplyLeaveResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
