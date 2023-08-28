// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suku/AppModule/HomeFeatures/LeaveHistory/Controller/leave_controller.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class LeaveHistory extends StatelessWidget {
  LeaveHistory({Key? key}) : super(key: key);

  final leaveController = Get.put(LeaveController());
  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryAppBar(
            isPrefix: true,
            title: "leaveHistory".tr,
            onTap: () {
              Get.back();
            },
          ),
          Obx(() {
            return leaveController.isLoading.value
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
                : leaveController.leaveAllList.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Get.height * 0.01),
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: leaveController.leaveAllList.length,
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
                                        vertical: 12,
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
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                // Container(
                                                //   width: 5,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                                                //         bottomLeft: Radius.circular(10)
                                                //
                                                //     ),
                                                //     color: randomColor(),
                                                //   ),
                                                //   height: Get.height * 0.1,
                                                // ),
                                                // SizedBox(
                                                //   width: 20,
                                                // ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                bottom: 8.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(10),
                                                              color: AppColors
                                                                  .primaryColor),
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 6),
                                                            child: AppText(
                                                              title: leaveController
                                                                  .leaveAllList[index]
                                                                  .type,
                                                              color: AppColors
                                                                  .WHITE_COLOR,
                                                              fontFamily:
                                                                  Weights.medium,
                                                              size:
                                                                  Get.height * 0.015,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.6,
                                                        child: Text(
                                                          leaveController
                                                                  .leaveAllList[index]
                                                                  .reason ??
                                                              "",
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                          maxLines: 3,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                Weights.medium,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 8.0),
                                                  child: AppText(
                                                    title:
                                                        " ${DateFormat('dd MMM yyyy').format(
                                                      leaveController
                                                          .leaveAllList[index]
                                                          .createdAt,
                                                    )}",
                                                    color:leaveController
                                                        .leaveAllList[
                                                    index]
                                                        .approved ==
                                                        "0"
                                                        ? Colors.red
                                                        : leaveController
                                                        .leaveAllList[
                                                    index]
                                                        .approved ==
                                                        "1"
                                                        ? Colors.green
                                                        : Colors.black,
                                                    fontFamily: Weights.semi,
                                                    size: Get.height * 0.016,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 8.0),
                                                  child: Row(
                                                    children: [
                                                      AppText(
                                                        title: leaveController
                                                                    .leaveAllList[
                                                                        index]
                                                                    .approved ==
                                                                "1/0"
                                                            ? ""
                                                            : "  ",
                                                        color: AppColors
                                                            .DARK_TEXT_COLOR,
                                                        fontFamily: Weights.semi,
                                                        size: Get.height * 0.016,
                                                      ),
                                                      AppText(
                                                        title: leaveController
                                                                    .leaveAllList[
                                                                        index]
                                                                    .approved ==
                                                                "0"
                                                            ? "Rejected"
                                                            : leaveController
                                                                        .leaveAllList[
                                                                            index]
                                                                        .approved ==
                                                                    "1"
                                                                ? "Accepted"
                                                                : "Waiting",
                                                        color: leaveController
                                                                    .leaveAllList[
                                                                        index]
                                                                    .approved ==
                                                                "0"
                                                            ? Colors.red
                                                            : leaveController
                                                                        .leaveAllList[
                                                                            index]
                                                                        .approved ==
                                                                    "1"
                                                                ? Colors.green
                                                                : Colors.black,
                                                        fontFamily: Weights.semi,
                                                        size: Get.height * 0.015,
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
                            title: "noData".tr,
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
