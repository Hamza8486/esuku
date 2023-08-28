// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suku/AppModule/Authentication/Login/Model/login_model.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/Home/Model/home_model.dart';
import 'package:suku/AppModule/Home/View/home_view.dart';
import 'package:suku/AppModule/HomeFeatures/ApplyLeave/Model/model.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Model/attendence_model.dart';
import 'package:suku/AppModule/HomeFeatures/Exams/Model/exam_model.dart';
import 'package:suku/AppModule/HomeFeatures/Fees/Model/fees_model.dart';
import 'package:suku/AppModule/HomeFeatures/HomeWork/Model/work_model.dart';
import 'package:suku/AppModule/HomeFeatures/LeaveHistory/Model/leave_model.dart';
import 'package:suku/AppModule/HomeFeatures/Logout/Model/model.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Model/mark_model.dart';
import 'package:suku/AppModule/HomeFeatures/Notifications/Model/notification_model.dart';
import 'package:suku/AppModule/HomeFeatures/TimeTable/Model/time_model.dart';
import 'package:suku/Services/api_constants.dart';
import 'package:suku/Services/helper_function.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class ApiManger extends GetConnect {
  static var client = http.Client();

  static Uri uriPath({required String nameUrl}) {
    print("Url: ${ApiConstants.baseURL}$nameUrl");
    return Uri.parse(ApiConstants.baseURL + nameUrl);
  }

  void saveStudentInfoToPrefs(List<Map<String, dynamic>> students) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> studentInfoList = students.map<String>((student) {
      return "${student["id"]}_${student["first_name"]}";
    }).toList();

    prefs.setStringList("student_info", studentInfoList);
  }

  Future<void> saveSelectedStudentId(String selectedId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("selected_student_id", selectedId);
  }

   Future<LoginResponse?> loginResponse({
    var name,
    var password,
    var token
  }) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['username'] = name;
    body['password'] = password;
    body['device_token'] = token;
    var response =
        await client.post(uriPath(nameUrl: ApiConstants.loginURI), body: body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);

      if(jsonString["user"]["type"]=="student"){
        HelperFunctions.saveInPreference("token", jsonString["token"].toString());
        HelperFunctions.saveInPreference(
            "userId", jsonString["user"]["id"].toString());
        Get.put(HomeController()).updateStudentId(jsonString["user"]["id"].toString());
        Get.put(HomeController()).updateTypeId(jsonString["user"]["type"].toString());
        HelperFunctions.saveInPreference(
            "type", jsonString["user"]["type"].toString());
      }
      else{
        HelperFunctions.saveInPreference("token", jsonString["token"].toString());
        HelperFunctions.saveInPreference(
            "userId", jsonString["user"]["students"][0]["id"].toString());
        Get.put(HomeController()).updateStudentId(jsonString["user"]["students"][0]["id"].toString());
        HelperFunctions.saveInPreference(
            "type", jsonString["user"]["type"].toString());
        Get.put(HomeController()).updateTypeId(jsonString["user"]["type"].toString());
        saveSelectedStudentId(jsonString["user"]["students"][0]["id"].toString());

        List<dynamic> students = jsonString["user"]["students"];
        List<Map<String, dynamic>> studentInfoList = students.map<Map<String, dynamic>>((student) {
          return {
            "id": student["id"],
            "first_name": student["first_name"],
          };
        }).toList();
        saveStudentInfoToPrefs(studentInfoList);
      }
      print("object...");



      Get.back();
      print(jsonString["user"]["id"].toString());
      Get.offAll(HomeView());

      Get.snackbar(
        "Message",
        "",

        duration: Duration(seconds: 2),
        messageText: AppText(
          title: "Login Successful".tr,
          fontFamily: Weights.medium,
          color: AppColors.WHITE_COLOR,
        ),
        colorText: AppColors.WHITE_COLOR,
      );

      return loginResponseFromJson(response.body);
    } else if (response.statusCode == 202) {
      var jsonString = jsonDecode(response.body);
      print("object...");
      Get.back();

      Get.snackbar(
        "Error".tr,
        "",
        duration: Duration(seconds: 3),
        messageText: AppText(
          title: jsonString["message"].toString(),
          fontFamily: Weights.medium,
          color: AppColors.DARK_TEXT_COLOR,
        ),
        colorText: AppColors.DARK_TEXT_COLOR,
      );
      print(response.statusCode);
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<ApplyLeaveResponse?> applyResponse({
    var date,
    var endDate,
    var token,
    var type,
    var reason,
  }) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['type'] = type;
    body['start_date'] = date;
    body['end_date'] = endDate;
    body['student_id'] = Get.put(HomeController()).id.value;
    body['reason'] = reason;

    var response = await client.post(uriPath(nameUrl: ApiConstants.applyLeave),
        body: body,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("object...");

      Get.back();

      Get.offAll(HomeView());

      Get.snackbar(

        "Message",

        "",
        duration: Duration(seconds: 2),
        messageText: AppText(
          title: "Leave Applied Successfully".tr,
          fontFamily: Weights.medium,
          color: AppColors.WHITE_COLOR,
        ),
        colorText: AppColors.WHITE_COLOR,
      );

      return applyLeaveResponseFromJson(response.body);
    } else if (response.statusCode == 202) {
      var jsonString = jsonDecode(response.body);
      print("object...");
      Get.back();

      Get.snackbar(
        "Error",
        "",
        duration: Duration(seconds: 3),
        messageText: AppText(
          title: jsonString["error"].toString(),
          fontFamily: Weights.medium,
          color: AppColors.DARK_TEXT_COLOR,
        ),
        colorText: AppColors.DARK_TEXT_COLOR,
      );
      print(response.statusCode);
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<AttendenceResponse?> attendenceResponse({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.attendence}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return attendenceResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<HomeResponse?> homeResponse({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.home}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return homeResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<MarkResponse?> markResponse({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.mark}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return markResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<NotificationResponse?> notificationResponse({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.notification}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return notificationResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<TimeTableResponse?> timeTableResp({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.timeTable}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return timeTableResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<HomeWorkResponse?> homeWorkResp({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.homeWork}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return homeWorkResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<FeesResponse?> feeResp({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.fee}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return feesResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<ExamResponse?> examResp({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.exam}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return examResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<LeaveResponse?> leaveResp({token}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.leave}?student_id=${Get.put(HomeController()).id.value}"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return leaveResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<LogoutResponse?> logoutResp({token}) async {
    var response =
        await client.get(uriPath(nameUrl: ApiConstants.logout), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return logoutResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

//edit profile
   editProfile({var image,var token}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'student_id': Get.put(HomeController()).id.value,
          'image': await dio.MultipartFile.fromFile(image.path),

        });
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.image,
          data: data,
            options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
            }
            )
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(HomeController()).homeList(
             Get.put(HomeController()).token.value,);

          Get.back();
          Get.snackbar("Successfully".tr, "",
              colorText: AppColors.WHITE_COLOR,
              messageText: AppText(title: "Student Profile Picture Updated Successfully".tr,
              color: AppColors.WHITE_COLOR,
              ));
        } else {
          Get.back();
        }
      } on dio.DioError catch (e) {
        print(e.response);
        Get.back();
      }
    } on dio.DioError catch (e) {
      print(e.toString());
      Get.back();
    }
  }
  static Future<LogoutResponse?> logoutResponse({token}) async {
    var response =
    await client.get(uriPath(nameUrl: ApiConstants.logout), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return logoutResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }
}
