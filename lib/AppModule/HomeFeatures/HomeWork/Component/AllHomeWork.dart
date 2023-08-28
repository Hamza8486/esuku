// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suku/AppModule/HomeFeatures/HomeWork/Controller/work_controller.dart';
import 'package:suku/Utils/Constants/strings.dart';

import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class AllHomeWork extends StatelessWidget {
  AllHomeWork({Key? key}) : super(key: key);
  final workController = Get.put(WorkController());
  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Obx(() {
      return workController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
          : workController.homeWorkList.isNotEmpty
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: workController.homeWorkList.length,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
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

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(bottom: 8.0,right: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  workController.homeWorkList[index]
                                                          .subject.name ??
                                                      "subject",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                AppText(
                                                  title: DateFormat('dd MMM yyyy').format(
                                                    workController.homeWorkList[index].date,
                                                  ),
                                                  color: AppColors.DARK_TEXT_COLOR,
                                                  fontFamily: Weights.medium,
                                                  size: Get.height * 0.014,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width*0.85,
                                            child: Text(

                                              workController
                                                  .homeWorkList[index].homework,
                                              maxLines: 20,
                                              textAlign: TextAlign.start,
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
                      title: "No HomeWork".tr,
                      color: AppColors.DARK_TEXT_COLOR,
                      fontFamily: Weights.semi,
                    )),
                  ],
                );
    });
  }
}
