// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suku/AppModule/Authentication/Login/View/login_view.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Controller/controller.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/View/Attendance.dart';
import 'package:suku/AppModule/HomeFeatures/Exams/Controller/exam_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Exams/View/exam_view.dart';
import 'package:suku/AppModule/HomeFeatures/Fees/Controller/fees_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Fees/View/fees_view.dart';
import 'package:suku/AppModule/HomeFeatures/LeaveHistory/Controller/leave_controller.dart';
import 'package:suku/AppModule/HomeFeatures/LeaveHistory/View/leave_history.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Controller/mark_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Notifications/Controller/notification_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Notifications/View/notification_view.dart';
import 'package:suku/AppModule/HomeFeatures/Profile/View/profile_view.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';
import 'package:suku/Utils/Widgets/drawe_list_tile.dart';

class DrawerData extends StatefulWidget {
  DrawerData({Key? key}) : super(key: key);

  @override
  State<DrawerData> createState() => _DrawerDataState();
}

class _DrawerDataState extends State<DrawerData> {
  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'French', 'locale': Locale('hi', 'IN')},
  ];

  final homeController = Get.put(HomeController());
  final attendenceController = Get.put(AttendenceListController());
  final markController = Get.put(MarkController());

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('selectLang'.tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          debugPrint(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                          HelperFunctions.saveInPreference(
                              "language", locale[index]['name']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }
  var token = "";

  late List<Map<String, dynamic>> studentInfo = [];


  Future<void> fetchStudentInfo() async {
    List<Map<String, dynamic>> savedStudentInfo =
    await getSavedStudentInfoFromPrefs();
    setState(() {
      studentInfo = savedStudentInfo;
    });
  }
  Future<void> saveSelectedStudentId(String selectedId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("selected_student_id", selectedId);
  }

  Future<String?> getSavedSelectedStudentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selected_student_id");
  }
  Future<void> initializeSelectedStudentId() async {
    String? savedSelectedStudentId = await getSavedSelectedStudentId();
    setState(() {
      selectedStudentId = savedSelectedStudentId;
    });
  }


  String marks = "";
  String? selectedStudentId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperFunctions.getFromPreference("token").then((value) {
      token = value;

    });
    fetchStudentInfo();
    initializeSelectedStudentId();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.only(
            left: Get.width * 0.04,
            top: Get.height * 0.06,
            bottom: Get.height * 0.06,
            right: Get.width * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.17),
              child: Container(
                  height: Get.height*0.12,
                  width: Get.height*0.12,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.WHITE_COLOR),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(100),
                    child: Image.network(
                        homeController.homeModel?.image??"",
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, exception,
                            stackTrace) {
                          return ClipRRect(
                            borderRadius:
                            BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/persons.jpg",
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                    ),
                  )
              ),
            ),
            SizedBox(
              height: Get.height * 0.014,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  title: homeController.homeModel?.firstName ?? "",
                  color: AppColors.WHITE_COLOR,
                  fontFamily: Weights.medium,
                  size: Get.height * 0.02,
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                AppText(
                  title: homeController.homeModel?.lastName ?? "",
                  color: AppColors.WHITE_COLOR,
                  fontFamily: Weights.medium,
                  size: Get.height * 0.02,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              children: [
                Obx(
                  () {
                    return

                      homeController.type.value=="parent"?
                      Row(

                      children: [
                        IconButton(
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                            icon: FaIcon(FontAwesomeIcons.userGroup,size: 20,),
                            onPressed: () { print("Pressed"); }
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: DropdownButton<String>(
                            value: selectedStudentId,
                            elevation: 0,
                            style: TextStyle(color: Colors.white,
                            fontFamily: Weights.medium
                            ),
                            icon: SizedBox.shrink(),
                            underline: SizedBox.shrink(),
                             borderRadius: BorderRadius.circular(10),
                             dropdownColor: Color(0xFFD3D3D3),
                            items: studentInfo.map((student) {
                              return DropdownMenuItem<String>(
                                value: student["id"].toString(),
                                child: Text(student["first_name"]),
                              );
                            }).toList(),
                            onChanged: (selectedId) {
                              setState(() {
                                selectedStudentId = selectedId;
                                saveSelectedStudentId(selectedId.toString()); // Save selected student ID
                                print("Selected Student ID: $selectedId");
                                HelperFunctions.saveInPreference("userId", selectedId.toString());
                                Get.put(HomeController()).updateStudentId(selectedId.toString());
                                homeController.homeList(token);
                                attendenceController.attendenceListAll(token);
                                markController.markList(token);
                              });
                            },
                            hint: Text("Select a student"),
                          ),
                        ),

                        // Padding(
                        //   padding:  EdgeInsets.only(bottom: 3),
                        //   child: AppText(
                        //     title: 'Students'.tr,
                        //     size: Get.height * 0.018,
                        //     color: AppColors.WHITE_COLOR,
                        //     fontFamily: Weights.medium,
                        //   ),
                        // )
                      ],
                    ):SizedBox.shrink();
                  }
                ),
                GestureDetector(
                  onTap: () {
                    buildLanguageDialog(context);
                  },
                  child: Row(

                    children: [
                      IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(FontAwesomeIcons.flag,size: 23,),
                          onPressed: () { print("Pressed"); }
                      ),

                      Padding(
                        padding:  EdgeInsets.only(bottom: 3),
                        child: AppText(
                          title: 'language'.tr,
                          size: Get.height * 0.018,
                          color: AppColors.WHITE_COLOR,
                          fontFamily: Weights.medium,
                        ),
                      )
                    ],
                  ),
                ),
                DrawerListTile(
                  icon: FaIcon(FontAwesomeIcons.calendarCheck, size: 23,),
                  name: "attend".tr,
                  ontap: () {
                    attendenceController.attendenceListAll(token);
                    Get.to(Attendance());
                  },
                ),
                DrawerListTile(
                    icon: FaIcon(FontAwesomeIcons.idBadge, size: 23,),

                    name: "profile".tr, ontap: () {
                  Get.to(ProfileView());
                }),
                DrawerListTile(

                  icon: FaIcon(FontAwesomeIcons.noteSticky, size: 23,),
                  name: "exam".tr,
                  ontap: () {
                    Get.put(ExamController()).examList(token);
                    Get.to(ExamsView());
                  },
                ),
      // homeController.homeModel?.type == "student"?Container():
                    Obx(
                      () {
                        return
                          homeController.type.value=="parent"?

                          DrawerListTile(
                        icon: FaIcon(FontAwesomeIcons.creativeCommonsNcEu, size: 23,),
                            name: "fees".tr,
                            ontap: () {
                              Get.put(FeeController()).feeList(token);
                              Get.to(FeeView());
                            }):SizedBox.shrink();
                      }
                    ),
                DrawerListTile(
                  icon: FaIcon(FontAwesomeIcons.calendarMinus, size: 23,),
                  name: "leaveHistory".tr,
                  ontap: () {
                    Get.put(LeaveController()).leaveList(token);
                    Get.to(LeaveHistory());
                  },
                ),
                DrawerListTile(
                    icon: FaIcon(FontAwesomeIcons.bell, size: 23,),
                    name: "notification".tr,
                    ontap: () {
                      Get.put(NotificationController()).notiList(token);
                      Get.to(NotificationView());
                    }),
                DrawerListTile(
                    icon: FaIcon(FontAwesomeIcons.circleRight, size: 23,),
                    name: "logout".tr,
                    ontap: () {
                      ApiManger.logoutResp(token: token);
                      HelperFunctions.clearPrefs();
                      Get.offAll(LoginView());
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
  Future<List<Map<String, dynamic>>> getSavedStudentInfoFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? studentInfoList = prefs.getStringList("student_info");

    if (studentInfoList != null) {
      List<Map<String, dynamic>> studentInfo = studentInfoList.map((info) {
        List<String> parts = info.split('_');
        return {
          "id": int.parse(parts[0]),
          "first_name": parts[1],
        };
      }).toList();

      return studentInfo;
    }

    return [];
  }
}
