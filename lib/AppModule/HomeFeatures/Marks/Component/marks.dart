// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Controller/mark_controller.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class Marks extends StatelessWidget {
  Marks({Key? key}) : super(key: key);

  final markController = Get.put(MarkController());
  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));

  var marks;
  @override
  Widget build(BuildContext context) {
    return   Obx(() {
      return markController.isLoading.value
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
          : markController.markListData.isNotEmpty
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemCount: markController.markListData.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  markController.markListData[index].marks == null?Container():
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 13,
                      ),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [


                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: double.parse(markController.markListData[index].marks.toString()).toInt()<=9?

                                                Colors.red:

                                                double.parse(markController.markListData[index].marks.toString()).toInt()>=13?

                                                Colors.green:AppColors.exitColor,
                                                borderRadius:
                                                BorderRadius.circular(10),

                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Center(
                                                  child: Text(
                                                    markController
                                                        .markListData[index].marks.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            AppText(
                                              title: markController
                                                  .markListData[index]
                                                  .exam
                                                  .subject
                                                  .name.substring(0,3),
                                              color:
                                              AppColors.DARK_TEXT_COLOR,
                                              fontFamily: Weights.semi,
                                              size: Get.height * 0.018,
                                            ),
                                            AppText(
                                              title: DateFormat('dd MMM yyyy').format(
                                                markController
                                                    .markListData[index].createdAt,
                                              ),
                                              color: AppColors.DARK_TEXT_COLOR,
                                              fontFamily: Weights.medium,
                                              size: Get.height * 0.016,
                                            )

                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
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
                title: "No Marks".tr,
                color: AppColors.DARK_TEXT_COLOR,
                fontFamily: Weights.semi,
              )),
        ],
      );
    });
  }
}