// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Controller/controller.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';
import 'package:intl/intl.dart';

class TodayAttendance extends StatelessWidget {
  TodayAttendance({Key? key}) : super(key: key);
  final attendenceController = Get.put(AttendenceListController());
  final homeController = Get.put(HomeController());
  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return attendenceController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
          : attendenceController.attendenceTodayList.isNotEmpty
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: attendenceController.attendenceTodayList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.007,
                          horizontal: Get.width * 0.04),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 3),
                              //blurRadius: 3,
                              //spreadRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04,
                              vertical: Get.height * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: randomColor(),
                                    ),
                                    height: Get.height * 0.1,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        title: DateFormat('EEEE').format(
                                          attendenceController
                                              .attendenceTodayList[index].date,
                                        ),
                                        color: AppColors.DARK_TEXT_COLOR,
                                        fontFamily: Weights.medium,
                                        size: Get.height * 0.016,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppText(
                                        title: DateFormat('yyyy-MM-dd').format(
                                          attendenceController
                                              .attendenceTodayList[index].date,
                                        ),
                                        color: AppColors.DARK_TEXT_COLOR,
                                        fontFamily: Weights.medium,
                                        size: Get.height * 0.016,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    attendenceController
                                            .attendenceTodayList[index]
                                            .subject
                                            .name ??
                                        "subject",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${homeController.homeModel?.firstName ?? ""} ${homeController.homeModel?.lastName ?? ""}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              attendenceController.attendenceTodayList[index]
                                          .attendance ==
                                      "Absent"
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "A",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "P",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      )),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: AppText(
                  title: "No Today Attendance",
                  color: AppColors.DARK_TEXT_COLOR,
                ));
    });
  }
}
