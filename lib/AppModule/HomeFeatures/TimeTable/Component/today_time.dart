// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:suku/AppModule/HomeFeatures/TimeTable/Controller/time_controller.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class TodayTime extends StatelessWidget {
  TodayTime({Key? key}) : super(key: key);
  final timeController = Get.put(TimeController());
  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Obx(() {
      return timeController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
          : timeController.todayTimeTableList.isNotEmpty
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: timeController.todayTimeTableList.length,
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
                                            timeController.todayTimeTableList[index]
                                                    .subject.name ??
                                                "subject",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${timeController.todayTimeTableList[index].subject.teacher.firstName ?? "teacher"} ${timeController.todayTimeTableList[index].subject.teacher.lastName ?? "name"}",
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
                            padding:  EdgeInsets.symmetric(   horizontal: Get.width*0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: AppText(
                                        title: timeController
                                            .todayTimeTableList[index].day,
                                        color: AppColors.DARK_TEXT_COLOR,
                                        fontFamily: Weights.medium,
                                        size: Get.height * 0.016,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0,right: 10),
                                    child: Row(
                                      children: [
                                        AppText(
                                          title:
                                          timeController
                                              .todayTimeTableList[index]
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
                                              .todayTimeTableList[index]
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
                  })
              : Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.4,
                    ),
                    Center(
                        child: AppText(
                      title: "No timeTable today".tr,
                      color: AppColors.DARK_TEXT_COLOR,
                      fontFamily: Weights.semi,
                    )),
                  ],
                );
    });
  }
}
