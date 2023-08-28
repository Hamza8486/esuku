// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Controller/controller.dart';
import 'package:suku/AppModule/HomeFeatures/TimeTable/Controller/time_controller.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';
import 'package:intl/intl.dart';


class WeekAttendence extends StatelessWidget {
  WeekAttendence({Key? key}) : super(key: key);
  final timeController = Get.put(TimeController());
  final homeController = Get.put(HomeController());
  final attendenceController = Get.put(AttendenceListController());
  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));
  @override
  Widget build(BuildContext context) {
    return  Obx(
            () {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding:  EdgeInsets.symmetric( horizontal: Get.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:timeController.expand.value == true? AppColors.WHITE_COLOR:AppColors.DARK_TEXT_COLOR
                        )),
                    child: ExpansionTile(
                      title:  Text(
                        'Monday'.tr,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.DARK_TEXT_COLOR,
                        ),
                      ),
                      trailing: timeController.expand.value == true
                          ?  const Icon(Icons.keyboard_arrow_up, color: AppColors.primaryColor)
                          :  Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.DARK_TEXT_COLOR),
                      onExpansionChanged: (bool val) {
                        timeController.expand.value = val;
                      },

                      children:  [
                        attendenceController.monday.isNotEmpty?
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: attendenceController.monday.length,
                            itemBuilder: (BuildContext context, int index) {
                              return
                                attendenceController.monday[index]
                                    .subject == null?Container():

                                Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.007,
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.01
                                  ),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: randomColor(),
                                  ),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                      ),
                                      border: Border.all(color: AppColors.DARK_TEXT_COLOR.withOpacity(0.5)),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Get.width*0.02,

                                          vertical: Get.height * 0.015),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: DateFormat('EEEE').format(
                                                      attendenceController
                                                          .monday[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppText(
                                                    title: DateFormat('dd MMM yyyy').format(
                                                      attendenceController
                                                          .monday[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  )
                                                ],
                                              ),

SizedBox(width: Get.width*0.07,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    attendenceController.monday[index]
                                                        .subject.name ??
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
                                            ],
                                          ),

                                          attendenceController
                                              .monday[index].attendance ==
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
                                ),
                              );
                            }):  Center(
                            child: AppText(
                              title: "No Attendance".tr,
                              color: AppColors.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.025),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:timeController.expand1.value == true? AppColors.WHITE_COLOR:AppColors.DARK_TEXT_COLOR
                        )),
                    child: ExpansionTile(
                      title:  Text(
                        'Tuesday'.tr,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.DARK_TEXT_COLOR,
                        ),
                      ),
                      trailing: timeController.expand1.value == true
                          ?  const Icon(Icons.keyboard_arrow_up, color: AppColors.primaryColor)
                          :  Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.DARK_TEXT_COLOR),
                      onExpansionChanged: (bool val) {
                        timeController.expand1.value = val;
                      },

                      children:  [
                        attendenceController.tue.isNotEmpty?
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: attendenceController.tue.length,
                            itemBuilder: (BuildContext context, int index) {
                              return

                                attendenceController.tue[index]
                                    .subject == null?Container():
                                Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.007,
                                 ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.01
                                  ),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: randomColor(),
                                  ),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                      ),
                                      border: Border.all(color: AppColors.DARK_TEXT_COLOR.withOpacity(0.5)),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width*0.02,
                                          vertical: Get.height * 0.015),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: DateFormat('EEEE').format(
                                                      attendenceController
                                                          .tue[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppText(
                                                    title: DateFormat('dd MMM yyyy').format(
                                                      attendenceController
                                                          .tue[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: Get.width*0.07,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    attendenceController.tue[index]
                                                        .subject.name ??
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
                                            ],
                                          ),

                                          attendenceController
                                              .tue[index].attendance ==
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
                                ),
                              );
                            }):  Center(
                            child: AppText(
                              title: "No Attendance".tr,
                              color: AppColors.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.025),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:timeController.expand2.value == true? AppColors.WHITE_COLOR:AppColors.DARK_TEXT_COLOR
                        )),
                    child: ExpansionTile(
                      title:  Text(
                        'Wednesday'.tr,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.DARK_TEXT_COLOR,
                        ),
                      ),
                      trailing: timeController.expand2.value == true
                          ?  const Icon(Icons.keyboard_arrow_up, color: AppColors.primaryColor)
                          :  Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.DARK_TEXT_COLOR),
                      onExpansionChanged: (bool val) {
                        timeController.expand2.value = val;
                      },

                      children:  [
                        attendenceController.wed.isNotEmpty?
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: attendenceController.wed.length,
                            itemBuilder: (BuildContext context, int index) {
                              return

                                attendenceController.wed[index]
                                    .subject == null?Container():
                                Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.007,
                                   ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.01
                                  ),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: randomColor(),
                                  ),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                      ),
                                      border: Border.all(color: AppColors.DARK_TEXT_COLOR.withOpacity(0.5)),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.02,
                                          vertical: Get.height * 0.015),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: DateFormat('EEEE').format(
                                                      attendenceController
                                                          .wed[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppText(
                                                    title: DateFormat("dd MMM yyyy").format(
                                                      attendenceController
                                                          .wed[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: Get.width*0.07,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    attendenceController.wed[index]
                                                        .subject.name ??
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
                                            ],
                                          ),

                                          attendenceController
                                              .wed[index].attendance ==
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
                                ),
                              );
                            }):  Center(
                            child: AppText(
                              title: "No Attendance".tr,
                              color: AppColors.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.025),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:timeController.expand3.value == true? AppColors.WHITE_COLOR:AppColors.DARK_TEXT_COLOR
                        )),
                    child: ExpansionTile(
                      title:  Text(
                        'Thursday'.tr,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.DARK_TEXT_COLOR,
                        ),
                      ),
                      trailing: timeController.expand3.value == true
                          ?  const Icon(Icons.keyboard_arrow_up, color: AppColors.primaryColor)
                          :  Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.DARK_TEXT_COLOR),
                      onExpansionChanged: (bool val) {
                        timeController.expand3.value = val;
                      },

                      children:  [
                        attendenceController.thur.isNotEmpty?
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: attendenceController.thur.length,
                            itemBuilder: (BuildContext context, int index) {
                              return
                                attendenceController.thur[index]
                                    .subject == null?Container():

                                Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.007,
                                   ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.01
                                  ),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: randomColor(),
                                  ),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                      ),
                                      border: Border.all(color: AppColors.DARK_TEXT_COLOR.withOpacity(0.5)),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.02,
                                          vertical: Get.height * 0.015),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: DateFormat('EEEE').format(
                                                      attendenceController
                                                          .thur[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppText(
                                                    title: DateFormat('dd MMM yyyy').format(
                                                      attendenceController
                                                          .thur[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: Get.width*0.07,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    attendenceController.thur[index]
                                                        .subject.name ??
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
                                            ],
                                          ),

                                          attendenceController
                                              .thur[index].attendance ==
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
                                ),
                              );
                            }):  Center(
                            child: AppText(
                              title: "No Attendance".tr,
                              color: AppColors.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.025),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:timeController.expand4.value == true? AppColors.WHITE_COLOR:AppColors.DARK_TEXT_COLOR
                        )),
                    child: ExpansionTile(
                      title:  Text(
                        'Friday'.tr,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.DARK_TEXT_COLOR,
                        ),
                      ),
                      trailing: timeController.expand4.value == true
                          ?  const Icon(Icons.keyboard_arrow_up, color: AppColors.primaryColor)
                          :  Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.DARK_TEXT_COLOR),
                      onExpansionChanged: (bool val) {
                        timeController.expand4.value = val;
                      },

                      children:  [
                        attendenceController.frid.isNotEmpty?
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: attendenceController.frid.length,
                            itemBuilder: (BuildContext context, int index) {
                              return

                                attendenceController.frid[index]
                                    .subject == null?Container():
                                Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.007,
                                   ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.01
                                  ),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: randomColor(),
                                  ),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                      ),
                                      border: Border.all(color: AppColors.DARK_TEXT_COLOR.withOpacity(0.5)),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width*0.02,
                                          vertical: Get.height * 0.015),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: DateFormat('EEEE').format(
                                                      attendenceController
                                                          .frid[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppText(
                                                    title: DateFormat('dd MMM yyyy').format(
                                                      attendenceController
                                                          .frid[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: Get.width*0.07,),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    attendenceController.frid[index]
                                                        .subject.name ??
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
                                            ],
                                          ),

                                          attendenceController
                                              .frid[index].attendance ==
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
                                ),
                              );
                            }):  Center(
                            child: AppText(
                              title: "No Attendance".tr,
                              color: AppColors.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.025),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:timeController.expand5.value == true? AppColors.WHITE_COLOR:AppColors.DARK_TEXT_COLOR
                        )),
                    child: ExpansionTile(
                      title:  Text(
                        'Saturday'.tr,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.DARK_TEXT_COLOR,
                        ),
                      ),
                      trailing: timeController.expand5.value == true
                          ?  const Icon(Icons.keyboard_arrow_up, color: AppColors.primaryColor)
                          :  Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.DARK_TEXT_COLOR),
                      onExpansionChanged: (bool val) {
                        timeController.expand5.value = val;
                      },

                      children:  [
                        attendenceController.sat.isNotEmpty?
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: attendenceController.sat.length,
                            itemBuilder: (BuildContext context, int index) {
                              return
                                attendenceController.sat[index]
                                    .subject == null?Container():

                                Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.007,
                                   ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.01
                                  ),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: randomColor(),
                                  ),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                      ),
                                      border: Border.all(color: AppColors.DARK_TEXT_COLOR.withOpacity(0.5)),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width*0.02,
                                          vertical: Get.height * 0.015),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: DateFormat('EEEE').format(
                                                      attendenceController
                                                          .sat[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppText(
                                                    title: DateFormat('dd MMM yyyy').format(
                                                      attendenceController
                                                          .sat[index].date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.015,
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: Get.width*0.07,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(


                                                    attendenceController.sat[index]
                                                        .subject.name ??
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
                                            ],
                                          ),

                                          attendenceController
                                              .sat[index].attendance ==
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
                                ),
                              );
                            }):  Center(
                            child: AppText(
                              title: "No Attendance".tr,
                              color: AppColors.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi,
                            )),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          );
        }
    );
  }
}





