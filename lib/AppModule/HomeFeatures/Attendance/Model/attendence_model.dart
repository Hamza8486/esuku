// To parse this JSON data, do
//
//     final attendenceResponse = attendenceResponseFromJson(jsonString);

import 'dart:convert';

AttendenceResponse attendenceResponseFromJson(String str) => AttendenceResponse.fromJson(json.decode(str));

String attendenceResponseToJson(AttendenceResponse data) => json.encode(data.toJson());

class AttendenceResponse {
  bool? status;
  List<Saturday>? monday;
  List<Saturday>? tuesday;
  List<Saturday>? wednesday;
  List<Saturday>? thursday;
  List<Saturday>? friday;
  List<Saturday>? saturday;
  int? presents;
  int? absents;
  int? leaves;
  int? lates;
  int? exits;
  String? message;

  AttendenceResponse(
      {this.status,
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.presents,
        this.absents,
        this.leaves,
        this.lates,
        this.exits,
        this.message});

  AttendenceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['monday'] != null) {
      monday = <Saturday>[];
      json['monday'].forEach((v) {
        monday!.add(new Saturday.fromJson(v));
      });
    }
    if (json['tuesday'] != null) {
      tuesday = <Saturday>[];
      json['tuesday'].forEach((v) {
        tuesday!.add(new Saturday.fromJson(v));
      });
    }
    if (json['wednesday'] != null) {
      wednesday = <Saturday>[];
      json['wednesday'].forEach((v) {
        wednesday!.add(new Saturday.fromJson(v));
      });
    }
    if (json['thursday'] != null) {
      thursday = <Saturday>[];
      json['thursday'].forEach((v) {
        thursday!.add(new Saturday.fromJson(v));
      });
    }
    if (json['friday'] != null) {
      friday = <Saturday>[];
      json['friday'].forEach((v) {
        friday!.add(new Saturday.fromJson(v));
      });
    }
    if (json['saturday'] != null) {
      saturday = <Saturday>[];
      json['saturday'].forEach((v) {
        saturday!.add(new Saturday.fromJson(v));
      });
    }
    presents = json['presents'];
    absents = json['absents'];
    leaves = json['leaves'];
    lates = json['lates'];
    exits = json['exits'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.monday != null) {
      data['monday'] = this.monday!.map((v) => v.toJson()).toList();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.map((v) => v.toJson()).toList();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.map((v) => v.toJson()).toList();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.map((v) => v.toJson()).toList();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.map((v) => v.toJson()).toList();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.map((v) => v.toJson()).toList();
    }
    data['presents'] = this.presents;
    data['absents'] = this.absents;
    data['leaves'] = this.leaves;
    data['lates'] = this.lates;
    data['exits'] = this.exits;
    data['message'] = this.message;
    return data;
  }
}

class Saturday {
  int? id;
  String? schoolCode;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? studentId;
  String? attendance;
  DateTime ? date;
  String? createdAt;
  String? updatedAt;
  Subject? subject;

  Saturday(
      {this.id,
        this.schoolCode,
        this.classId,
        this.sectionId,
        this.subjectId,
        this.studentId,
        this.attendance,
        this.date,
        this.createdAt,
        this.updatedAt,
        this.subject});

  Saturday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolCode = json['school_code'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    studentId = json['student_id'];
    attendance = json['attendance'];
    date = DateTime.parse(json['date']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subject =
    json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_code'] = this.schoolCode;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['subject_id'] = this.subjectId;
    data['student_id'] = this.studentId;
    data['attendance'] = this.attendance;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    return data;
  }
}

class Subject {
  int? id;
  String? schoolCode;
  String? subjectCode;
  String? name;
  String? classId;
  String? createdAt;
  String? updatedAt;

  Subject(
      {this.id,
        this.schoolCode,
        this.subjectCode,
        this.name,
        this.classId,
        this.createdAt,
        this.updatedAt});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolCode = json['school_code'];
    subjectCode = json['subject_code'];
    name = json['name']??"";
    classId = json['class_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_code'] = this.schoolCode;
    data['subject_code'] = this.subjectCode;
    data['name'] = this.name;
    data['class_id'] = this.classId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

