// To parse this JSON data, do
//
//     final markResponse = markResponseFromJson(jsonString);

import 'dart:convert';

MarkResponse markResponseFromJson(String str) => MarkResponse.fromJson(json.decode(str));

String markResponseToJson(MarkResponse data) => json.encode(data.toJson());

class MarkResponse {
  bool? status;
  List<Marks>? marks;
  List<SubjecctMarks>? subjecctMarks;
  String? message;

  MarkResponse({this.status, this.marks, this.subjecctMarks, this.message});

  MarkResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['marks'] != null) {
      marks = <Marks>[];
      json['marks'].forEach((v) {
        marks!.add(new Marks.fromJson(v));
      });
    }
    if (json['subjecct_marks'] != null) {
      subjecctMarks = <SubjecctMarks>[];
      json['subjecct_marks'].forEach((v) {
        subjecctMarks!.add(new SubjecctMarks.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.marks != null) {
      data['marks'] = this.marks!.map((v) => v.toJson()).toList();
    }
    if (this.subjecctMarks != null) {
      data['subjecct_marks'] =
          this.subjecctMarks!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Marks {
  int? id;
  String? examId;
  String? studentId;
  String? marks;
  DateTime? createdAt;
  String? updatedAt;
  Exam? exam;

  Marks(
      {this.id,
        this.examId,
        this.studentId,
        this.marks,
        this.createdAt,
        this.updatedAt,
        this.exam});

  Marks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    studentId = json['student_id'];
    marks = json['marks'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'];
    exam = json['exam'] != null ? new Exam.fromJson(json['exam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_id'] = this.examId;
    data['student_id'] = this.studentId;
    data['marks'] = this.marks;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.exam != null) {
      data['exam'] = this.exam!.toJson();
    }
    return data;
  }
}

class Exam {
  int? id;
  String? schoolCode;
  String? title;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? date;
  String? startHour;
  String? endHour;
  String? comments;
  String? createdAt;
  String? updatedAt;
  Subject? subject;

  Exam(
      {this.id,
        this.schoolCode,
        this.title,
        this.classId,
        this.sectionId,
        this.subjectId,
        this.date,
        this.startHour,
        this.endHour,
        this.comments,
        this.createdAt,
        this.updatedAt,
        this.subject});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolCode = json['school_code'];
    title = json['title'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    date = json['date'];
    startHour = json['start_hour'];
    endHour = json['end_hour'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subject =
    json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_code'] = this.schoolCode;
    data['title'] = this.title;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['subject_id'] = this.subjectId;
    data['date'] = this.date;
    data['start_hour'] = this.startHour;
    data['end_hour'] = this.endHour;
    data['comments'] = this.comments;
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
    name = json['name'];
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

class SubjecctMarks {
  int? id;
  String? schoolCode;
  String? subjectCode;
  String? name;
  String? classId;
  String? createdAt;
  String? updatedAt;
  List<Exams>? exams;

  SubjecctMarks(
      {this.id,
        this.schoolCode,
        this.subjectCode,
        this.name,
        this.classId,
        this.createdAt,
        this.updatedAt,
        this.exams});

  SubjecctMarks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolCode = json['school_code'];
    subjectCode = json['subject_code'];
    name = json['name'];
    classId = json['class_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(new Exams.fromJson(v));
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
    if (this.exams != null) {
      data['exams'] = this.exams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exams {
  int? id;
  String? schoolCode;
  String? title;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? date;
  String? startHour;
  String? endHour;
  String? comments;
  DateTime? createdAt;
  String? updatedAt;
  String? mark;

  Exams(
      {this.id,
        this.schoolCode,
        this.title,
        this.classId,
        this.sectionId,
        this.subjectId,
        this.date,
        this.startHour,
        this.endHour,
        this.comments,
        this.createdAt,
        this.updatedAt,
        this.mark});

  Exams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolCode = json['school_code'];
    title = json['title'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    date = json['date'];
    startHour = json['start_hour'];
    endHour = json['end_hour'];
    comments = json['comments'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'];
    mark = json['mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_code'] = this.schoolCode;
    data['title'] = this.title;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['subject_id'] = this.subjectId;
    data['date'] = this.date;
    data['start_hour'] = this.startHour;
    data['end_hour'] = this.endHour;
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mark'] = this.mark;
    return data;
  }
}

