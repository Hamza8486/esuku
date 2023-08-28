// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suku/AppModule/Home/Component/widgets.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/HomeFeatures/ApplyLeave/View/apply_leave_view.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Controller/controller.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/View/Attendance.dart';
import 'package:suku/AppModule/HomeFeatures/Exams/View/exam_view.dart';
import 'package:suku/AppModule/HomeFeatures/Fees/Controller/fees_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Fees/View/fees_view.dart';
import 'package:suku/AppModule/HomeFeatures/HomeWork/View/homework_view.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Controller/mark_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/View/marks_view.dart';
import 'package:suku/AppModule/HomeFeatures/Notifications/View/notification_view.dart';
import 'package:suku/AppModule/HomeFeatures/Profile/Controller/profile_controller.dart';
import 'package:suku/AppModule/HomeFeatures/TimeTable/View/time_view.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Loader/loader.dart';
import 'package:suku/Utils/Theme/app_colors.dart';

import 'package:suku/Utils/Widgets/app_text.dart';
import 'package:suku/Utils/Widgets/drawer_data.dart';
import 'package:suku/Utils/bottom_sheet.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final attendenceController = Get.put(AttendenceListController());
  final markController = Get.put(MarkController());
  late List<Map<String, dynamic>> studentInfo = [];

  final homeController = Get.put(HomeController());
  var token = "";
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

  File? _file;
  String marks = "";
  String? selectedStudentId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperFunctions.getFromPreference("token").then((value) {
      token = value;
      homeController.homeList(token);
    });
    fetchStudentInfo();
    initializeSelectedStudentId();
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    debugPrint("ProfileController().token.value");
    print(token);
    debugPrint(ProfileController().token.value);

    var size = Get.size;
    return WillPopScope(
      onWillPop: () => showExitPopup(context, token),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        key: _scaffoldKey,
        endDrawer: Drawer(
          elevation: 0,
          child: DrawerData(),
        ),
        body: Obx(() {
          return homeController.isLoading.value
              ? Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.55,
                    ),
                    Center(
                        child: CircularProgressIndicator(
                      color: AppColors.WHITE_COLOR,
                    )),
                  ],
                )
              : Column(
                  children: [
                    Material(
                      color: AppColors.primaryColor.withOpacity(0.9),
                      elevation: 2,
                      child: Container(
                        width: size.width,
                        height: size.height / 8.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.05,
                                  vertical: Get.height * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  bottomSheet(onCamera: () {
                                                    Navigator.pop(context);
                                                    HelperFunctions.pickImage(
                                                            ImageSource.camera)
                                                        .then((value) {
                                                      setState(() {
                                                        _file = value!;
                                                        appLoader(
                                                            context,
                                                            AppColors
                                                                .primaryColor);
                                                        ApiManger().editProfile(
                                                            image: value,
                                                            token: token);
                                                      });
                                                    });
                                                  }, onGallery: () {
                                                    Navigator.pop(context);
                                                    HelperFunctions.pickImage(
                                                            ImageSource.gallery)
                                                        .then((value) {
                                                      setState(() {
                                                        _file = value!;
                                                        appLoader(
                                                            context,
                                                            AppColors
                                                                .primaryColor);
                                                        ApiManger().editProfile(
                                                            image: value,
                                                            token: token);
                                                      });
                                                    });
                                                  }));
                                        },
                                        child: _file != null
                                            ? Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .primaryColor),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.file(
                                                    _file as File,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ))
                                            : Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .WHITE_COLOR),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.network(
                                                      homeController.homeModel
                                                              ?.image ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          exception,
                                                          stackTrace) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Image.asset(
                                                        "assets/persons.jpg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  }),
                                                )),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      AppText(
                                          title: "eSuku",
                                          size: size.height * 0.02,
                                          color: AppColors.WHITE_COLOR,
                                          fontFamily: Weights.semi),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: Icon(
                                      Icons.menu,
                                      color: AppColors.WHITE_COLOR,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04,
                              vertical: Get.height * 0.023),
                          child: Column(
                            children: [

                              SizedBox(
                                height: 10,
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(15),
                                elevation: 2,
                                color: AppColors.WHITE_COLOR,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05,
                                      vertical: Get.height * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [


                                      Row(
                                        children: [
                                          homeController.homeModel?.school
                                                      ?.image ==
                                                  null
                                              ? Container(
                                                  height: Get.height * 0.12,
                                                  width: Get.height * 0.12,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 4)),
                                                  child: Center(
                                                    child: AppText(
                                                      title: "Logo",
                                                      fontFamily:
                                                          Weights.medium,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: Get.height * 0.12,
                                                  width: Get.height * 0.12,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .WHITE_COLOR,
                                                          width: 1)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200),
                                                    child: Image.network(
                                                      homeController.homeModel
                                                              ?.school?.image ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                          SizedBox(
                                            width: Get.width * 0.08,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: Get.width * 0.5,
                                                  child: text(
                                                      text: homeController
                                                              .homeModel
                                                              ?.school
                                                              ?.name ??
                                                          Strings.schoolName),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  width: Get.width * 0.5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 11,
                                                            vertical: 5),
                                                    child: AppText(
                                                      fontFamily: Weights.semi,
                                                      size: Get.height * 0.016,
                                                      title:
                                                          "${homeController.homeModel?.firstName ?? Strings.stdName} ${homeController.homeModel?.lastName ?? Strings.stdName}",
                                                      maxLines: 1,
                                                      overFlow:
                                                          TextOverflow.ellipsis,
                                                      color: AppColors
                                                          .DARK_TEXT_COLOR,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.03,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(MarksView());
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              title: "Last Marks".tr,
                                              fontFamily: Weights.semi,
                                              size: Get.height * 0.018,
                                              color: AppColors.DARK_TEXT_COLOR,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: Get.height * 0.018,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      markController.markListData.isNotEmpty
                                          ? SizedBox(
                                              height: Get.height * 0.11,
                                              child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: markController
                                                      .markListData.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return markController
                                                                .markListData[
                                                                    index]
                                                                .marks ==
                                                            null
                                                        ? Container()
                                                        : Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: index ==
                                                                            0
                                                                        ? 0
                                                                        : 22),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 51,
                                                                  width: 51,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: double.parse(markController.markListData[index].marks.toString()).toInt() <=
                                                                            9
                                                                        ? Colors
                                                                            .red
                                                                        : double.parse(markController.markListData[index].marks.toString()).toInt() >=
                                                                                13
                                                                            ? Colors.green
                                                                            : AppColors.exitColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        AppText(
                                                                      title: markController
                                                                          .markListData[
                                                                              index]
                                                                          .marks
                                                                          .toString(),
                                                                      fontFamily:
                                                                          Weights
                                                                              .semi,
                                                                      size: Get
                                                                              .height *
                                                                          0.018,
                                                                      color: AppColors
                                                                          .WHITE_COLOR,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.01,
                                                                ),
                                                                AppText(
                                                                  title: markController
                                                                      .markListData[
                                                                          index]
                                                                      .exam
                                                                      .subject
                                                                      .name
                                                                      .substring(
                                                                          0, 3),
                                                                  fontFamily:
                                                                      Weights
                                                                          .semi,
                                                                  size:
                                                                      Get.height *
                                                                          0.0155,
                                                                  color: AppColors
                                                                      .DARK_TEXT_COLOR,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                  }),
                                            )
                                          : Center(
                                              child: AppText(
                                              title: "No Marks".tr,
                                              color: AppColors.DARK_TEXT_COLOR,
                                            )),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(Attendance());
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              title: "Attendance - Leave".tr,
                                              fontFamily: Weights.semi,
                                              size: Get.height * 0.017,
                                              color: AppColors.DARK_TEXT_COLOR,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: Get.height * 0.018,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Row(
                                        children: [
                                          boxWidget(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              text: attendenceController
                                                  .absent.value
                                                  .toString(),
                                              color: AppColors.absentColor,
                                              text1: "Absent".tr),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          boxWidget(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              text: attendenceController
                                                  .late.value
                                                  .toString(),
                                              color: AppColors.lateColor,
                                              text1: "Late".tr),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          boxWidget(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              text: attendenceController
                                                  .exit.value
                                                  .toString(),
                                              color: AppColors.exitColor,
                                              text1: "Exit".tr),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              dateList(
                                onPress: () {
                                  Get.to(TimeView());
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.calendar,
                                  size: 20,
                                ),
                                name: "time".tr,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              dateList(
                                onPress: () {
                                  Get.to(ExamsView());
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.noteSticky,
                                  size: 20,
                                ),
                                name: "exam".tr,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: dateList(
                                      onPress: () {
                                        Get.to(HomeWorkView());
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.rectangleList,
                                        size: 20,
                                      ),
                                      name: "work".tr,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: dateList(
                                      onPress: () {
                                        Get.to(NotificationView());
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.bell,
                                        size: 20,
                                      ),
                                      name: "notification".tr,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: dateList(
                                      onPress: () {
                                        markController.markList(token);
                                        Get.to(MarksView());
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.penToSquare,
                                        size: 20,
                                      ),
                                      name: "mark".tr,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: dateList(
                                      onPress: () {
                                        // attendenceController.attendenceListAll(token);
                                        attendenceController
                                            .attendenceListAll(token);
                                        Get.to(Attendance());
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.calendarCheck,
                                        size: 20,
                                      ),
                                      name: "attend".tr,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              // homeController.homeModel?.type == "student"
                              //     ? Container()
                              //     :

                              Obx(
                                () {
                                  return
                                    homeController.type.value=="parent"?


                                    Row(
                                    children: [
                                      Expanded(
                                        child: dateList(
                                          onPress: () {
                                            Get.put(FeeController()).feeList(token);
                                            Get.to(FeeView());
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.creativeCommonsNcEu,
                                            size: 20,
                                          ),
                                          name: "fees".tr,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: dateList(
                                          onPress: () {
                                            Get.to(ApplyLeaveView());
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.calendarXmark,
                                            size: 20,
                                          ),
                                          name: "apply".tr,
                                        ),
                                      ),
                                    ],
                                  ):SizedBox.shrink();
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
        }),
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

List marksAll = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
