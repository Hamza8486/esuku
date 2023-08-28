
// ignore_for_file: unnecessary_this

import 'dart:convert';

TimeTableResponse timeTableResponseFromJson(String str) => TimeTableResponse.fromJson(json.decode(str));

String timeTableResponseToJson(TimeTableResponse data) => json.encode(data.toJson());



class TimeTableResponse {
  bool? status;
  List<TodayTimetable>? todayTimetable;
  List<TodayTimetable>? monday;
  List<TodayTimetable>? tuesday;
  List<TodayTimetable>? wednesday;
  List<TodayTimetable>? thursday;
  List<TodayTimetable>? friday;
  List<TodayTimetable>? saturday;
  String? message;

  TimeTableResponse(
      {this.status,
        this.todayTimetable,
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.message});

  TimeTableResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['todayTimetable'] != null) {
      todayTimetable = <TodayTimetable>[];
      json['todayTimetable'].forEach((v) {
        todayTimetable!.add(new TodayTimetable.fromJson(v));
      });
    }
    if (json['monday'] != null) {
      monday = <TodayTimetable>[];
      json['monday'].forEach((v) {
        monday!.add(new TodayTimetable.fromJson(v));
      });
    }
    if (json['tuesday'] != null) {
      tuesday = <TodayTimetable>[];
      json['tuesday'].forEach((v) {
        tuesday!.add(new TodayTimetable.fromJson(v));
      });
    }
    if (json['wednesday'] != null) {
      wednesday = <TodayTimetable>[];
      json['wednesday'].forEach((v) {
        wednesday!.add(new TodayTimetable.fromJson(v));
      });
    }
    if (json['thursday'] != null) {
      thursday = <TodayTimetable>[];
      json['thursday'].forEach((v) {
        thursday!.add(new TodayTimetable.fromJson(v));
      });
    }
    if (json['friday'] != null) {
      friday = <TodayTimetable>[];
      json['friday'].forEach((v) {
        friday!.add(new TodayTimetable.fromJson(v));
      });
    }
    if (json['saturday'] != null) {
      saturday = <TodayTimetable>[];
      json['saturday'].forEach((v) {
        saturday!.add(new TodayTimetable.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.todayTimetable != null) {
      data['todayTimetable'] =
          this.todayTimetable!.map((v) => v.toJson()).toList();
    }
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
    data['message'] = this.message;
    return data;
  }
}

class TodayTimetable {
  int? id;
  String? schoolCode;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? day;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  Subject? subject;

  TodayTimetable(
      {this.id,
        this.schoolCode,
        this.classId,
        this.sectionId,
        this.subjectId,
        this.day,
        this.startTime,
        this.endTime,
        this.createdAt,
        this.updatedAt,
        this.subject});

  TodayTimetable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolCode = json['school_code'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
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
    data['day'] = this.day;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
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
  Teacher? teacher;
  List<Teachers>? teachers;

  Subject(
      {this.id,
        this.schoolCode,
        this.subjectCode,
        this.name,
        this.classId,
        this.createdAt,
        this.updatedAt,
        this.teacher,
        this.teachers});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolCode = json['school_code'];
    subjectCode = json['subject_code'];
    name = json['name'];
    classId = json['class_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
    if (json['teachers'] != null) {
      teachers = <Teachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(new Teachers.fromJson(v));
      });
    }
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
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.teachers != null) {
      data['teachers'] = this.teachers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? userId;
  String? schoolCode;
  String? firstName;
  String? lastName;
  String? gender;
  String? address;
  String? city;
  String? phone;
  String? email;
  String? username;
  String? password;
  String? createdAt;
  String? updatedAt;

  Teacher(
      {this.id,
        this.userId,
        this.schoolCode,
        this.firstName,
        this.lastName,
        this.gender,
        this.address,
        this.city,
        this.phone,
        this.email,
        this.username,
        this.password,
        this.createdAt,
        this.updatedAt});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    schoolCode = json['school_code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['school_code'] = this.schoolCode;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Teachers {
  int? id;
  String? teacherId;
  String? sectionId;
  String? subjectId;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;

  Teachers(
      {this.id,
        this.teacherId,
        this.sectionId,
        this.subjectId,
        this.createdAt,
        this.updatedAt,
        this.teacher});

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacher_id'] = this.teacherId;
    data['section_id'] = this.sectionId;
    data['subject_id'] = this.subjectId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    return data;
  }
}