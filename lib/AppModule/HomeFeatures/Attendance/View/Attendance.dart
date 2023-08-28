// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/AppModule/Home/Component/widgets.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Component/OverallAttendance.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Component/TodayAttendance.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Controller/controller.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Attendance extends StatelessWidget {
   Attendance({Key? key}) : super(key: key);
  final attendenceController = Get.put(AttendenceListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PrimaryAppBar(
            isPrefix: true,
            onTap: () {
              Get.back();
            },
            title: "This week attendance".tr,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boxWidget(
            borderRadius: BorderRadius.circular(30),
                    text: attendenceController.absent.value.toString(),
                    color: AppColors.absentColor,
                    text1: "Absent".tr),

                Padding(
                  padding:  EdgeInsets.only(right: Get.width*0.289),
                  child: boxWidget(
                      borderRadius: BorderRadius.circular(30),
                      text: attendenceController.late.value.toString(),
                      color: AppColors.lateColor,
                      text1: "Late".tr),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boxWidget(
            borderRadius: BorderRadius.circular(30),
                    text: attendenceController.leaves.value.toString(),
                    color: AppColors.leaveColor,
                    text1: "Leave".tr),

                Padding(
                  padding:  EdgeInsets.only(right: Get.width*0.3),
                  child: boxWidget(
                      borderRadius: BorderRadius.circular(30),
                      text: attendenceController.exit.value.toString(),
                      color: AppColors.exitColor,
                      text1: "Exit".tr),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.primaryColor,),

          Expanded(child: WeekAttendence())
        ],
      ),
    );
  }
}
