// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:suku/AppModule/HomeFeatures/Exams/Controller/exam_controller.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class ExamsView extends StatelessWidget {
  ExamsView({Key? key}) : super(key: key);

  final examController = Get.put(ExamController());

  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          PrimaryAppBar(
            isPrefix: true,
            title: "exam".tr,
            onTap: () {
              Get.back();
            },
          ),
          Obx(() {
            return examController.isLoading.value
                ? Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.4,
                      ),
                      Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
                    ],
                  )
                : examController.examAllList.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04,
                              vertical: Get.height * 0.02),
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: examController.examAllList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return    Container(
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(   left: Get.width*0.04,right: Get.width*0.02,
                                              top: Get.height*0.02,bottom: Get.height*0.02),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:Get.width*0.58,
                                                    child: Text(
                                                      examController.examAllList[index]
                                                          .subject.name ??
                                                          "subject",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        overflow: TextOverflow.ellipsis,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),

                                                  AppText(
                                                    title:  DateFormat('dd MMM yyyy')
                                                        .format(
                                                      examController.examAllList[index]
                                                          .date,
                                                    ),
                                                    color: AppColors.DARK_TEXT_COLOR,
                                                    fontFamily: Weights.medium,
                                                    size: Get.height * 0.016,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: Get.height*0.007,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:Get.width*0.58,
                                                    child: Text(
                                                        examController.examAllList[index]
                                                            .title,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontFamily: Weights.medium),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      AppText(
                                                        title:
                                                        examController.examAllList[index]
                                                            .startHour.substring(0,5),



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
                                                        title: examController.examAllList[index]
                                                            .endHour.substring(0,5),
                                                        color: AppColors.DARK_TEXT_COLOR,
                                                        fontFamily: Weights.medium,
                                                        size: Get.height * 0.016,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2,),
                                              SizedBox(
                                                width: Get.width*0.8,

                                                child: Text(
                                                  examController.examAllList[index]
                                                      .comments,
                                                  maxLines: 20,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      overflow: TextOverflow.ellipsis,

                                                      fontFamily: Weights.medium),
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.4,
                          ),
                          Center(
                              child: AppText(
                            title: "No Exam".tr,
                            color: AppColors.DARK_TEXT_COLOR,
                            fontFamily: Weights.semi,
                          )),
                        ],
                      );
          })
        ],
      ),
    );
  }
}
