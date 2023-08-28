// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/AppModule/HomeFeatures/TimeTable/Controller/time_controller.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';


class TimeC extends StatelessWidget {
   TimeC({Key? key}) : super(key: key);
  final timeController = Get.put(TimeController());
  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));
  @override
  Widget build(BuildContext context) {
    return  Obx(
       () {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                          timeController.monday.isNotEmpty?
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: timeController.monday.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.04
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02,
                                                      vertical: Get.height*0.02),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(bottom: 8.0),
                                                        child: Text(
                                                          timeController.monday[index]
                                                              .subject.name ??
                                                              "subject",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${timeController.monday[index].subject.teacher.firstName ?? "teacher"} ${timeController.monday[index].subject.teacher.lastName ?? "name"}",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: Weights.semi),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02,
                                                ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: AppText(
                                                      title: timeController
                                                          .monday[index].day,
                                                      color: AppColors.DARK_TEXT_COLOR,
                                                      fontFamily: Weights.medium,
                                                      size: Get.height * 0.016,
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: Row(
                                                    children: [
                                                      AppText(
                                                        title:
                                                        timeController
                                                            .monday[index]
                                                            .startTime.substring(0,5),



                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily:Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title: "-",
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title:   timeController
                                                            .monday[index]
                                                            .endTime.substring(0,5),
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ),
                                  );

                              }): Center(
                              child: AppText(
                                title: "No timetable".tr,
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
                          timeController.tue.isNotEmpty?
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: timeController.tue.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.04
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02,
                                                      vertical: Get.height*0.02),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(bottom: 8.0),
                                                        child: Text(
                                                          timeController.tue[index]
                                                              .subject.name ??
                                                              "subject",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${timeController.tue[index].subject.teacher.firstName ?? "teacher"} ${timeController.tue[index].subject.teacher.lastName ?? "name"}",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: Weights.semi),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02,
                                                ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: AppText(
                                                      title: timeController
                                                          .tue[index].day,
                                                      color: AppColors.DARK_TEXT_COLOR,
                                                      fontFamily: Weights.medium,
                                                      size: Get.height * 0.016,
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: Row(
                                                    children: [
                                                      AppText(
                                                        title:
                                                        timeController
                                                            .tue[index]
                                                            .startTime.substring(0,5),



                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title: "-",
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title:   timeController
                                                            .tue[index]
                                                            .endTime.substring(0,5),
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ),
                                  );

                              }): Center(
                              child: AppText(
                                title: "No timetable".tr,
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
                          timeController.wed.isNotEmpty?
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: timeController.wed.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.04
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02,
                                                      vertical: Get.height*0.02),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(bottom: 8.0),
                                                        child: Text(
                                                          timeController.wed[index]
                                                              .subject.name ??
                                                              "subject",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${timeController.wed[index].subject.teacher.firstName ?? "teacher"} ${timeController.wed[index].subject.teacher.lastName ?? "name"}",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: Weights.semi),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02,
                                              ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: AppText(
                                                      title: timeController
                                                          .wed[index].day,
                                                      color: AppColors.DARK_TEXT_COLOR,
                                                      fontFamily: Weights.medium,
                                                      size: Get.height * 0.016,
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                                                  child: Row(
                                                    children: [
                                                      AppText(
                                                        title:
                                                        timeController
                                                            .wed[index]
                                                            .startTime.substring(0,5),



                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title: "-",
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title:   timeController
                                                            .wed[index]
                                                            .endTime.substring(0,5),
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily:Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ),
                                  );
                              }): Center(
                              child: AppText(
                                title: "No timetable".tr,
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
                          timeController.thur.isNotEmpty?
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: timeController.thur.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.04
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02,
                                                    vertical: Get.height*0.02),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(bottom: 8.0),
                                                      child: Text(
                                                        timeController.thur[index]
                                                            .subject.name ??
                                                            "subject",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${timeController.thur[index].subject.teacher.firstName ?? "teacher"} ${timeController.thur[index].subject.teacher.lastName ?? "name"}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: Weights.semi),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: AppText(
                                                    title: timeController
                                                        .thur[index].day,
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.016,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                                                child: Row(
                                                  children: [
                                                    AppText(
                                                      title:
                                                      timeController
                                                          .thur[index]
                                                          .startTime.substring(0,5),



                                                      color: AppColors.DARK_TEXT_COLOR,
                                                      fontFamily: Weights.medium,
                                                      size: Get.height * 0.016,
                                                    ),
                                                    AppText(
                                                      title: "-",
                                                      color: AppColors.DARK_TEXT_COLOR,
                                                      fontFamily: Weights.medium,
                                                      size: Get.height * 0.016,
                                                    ),
                                                    AppText(
                                                      title:   timeController
                                                          .thur[index]
                                                          .endTime.substring(0,5),
                                                      color: AppColors.DARK_TEXT_COLOR,
                                                      fontFamily:Weights.medium,
                                                      size: Get.height * 0.016,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }): Center(
                              child: AppText(
                                title: "No timetable".tr,
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
                          timeController.frid.isNotEmpty?
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: timeController.frid.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.04
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.02,vertical: Get.height*0.02),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(bottom: 8.0),
                                                        child: Text(
                                                          timeController.frid[index]
                                                              .subject.name ??
                                                              "subject",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${timeController.frid[index].subject.teacher.firstName ?? "teacher"} ${timeController.frid[index].subject.teacher.lastName ?? "name"}",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: Weights.semi),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.02),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: AppText(
                                                      title: timeController
                                                          .frid[index].day,
                                                      color: AppColors.DARK_TEXT_COLOR,
                                                      fontFamily: Weights.medium,
                                                      size: Get.height * 0.016,
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: Row(
                                                    children: [
                                                      AppText(
                                                        title:
                                                        timeController
                                                            .frid[index]
                                                            .startTime.substring(0,5),



                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title: "-",
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title:   timeController
                                                            .frid[index]
                                                            .endTime.substring(0,5),
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ),
                                  );
                              }): Center(
                              child: AppText(
                                title: "No timetable".tr,
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
                          timeController.sat.isNotEmpty?
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: timeController.sat.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,
                                      horizontal: Get.width*0.04
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.02,vertical: Get.height*0.02),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(bottom: 8.0),
                                                        child: Text(
                                                          timeController.sat[index]
                                                              .subject.name ??
                                                              "subject",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${timeController.sat[index].subject.teacher.firstName ?? "teacher"} ${timeController.sat[index].subject.teacher.lastName ?? "name"}",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: Weights.semi),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.02),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: AppText(
                                                      title: timeController
                                                          .sat[index].day,
                                                      color: AppColors.DARK_TEXT_COLOR,
                                                      fontFamily: Weights.medium,
                                                      size: Get.height * 0.016,
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: Row(
                                                    children: [
                                                      AppText(
                                                        title:
                                                        timeController
                                                            .sat[index]
                                                            .startTime.substring(0,5),



                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title: "-",
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title:   timeController
                                                            .sat[index]
                                                            .endTime.substring(0,5),
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ),
                                  );
                              }): Center(
                              child: AppText(
                                title: "No timetable".tr,
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





