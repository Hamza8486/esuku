// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Fees/Controller/fees_controller.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class FeeView extends StatefulWidget {
  FeeView({Key? key}) : super(key: key);

  @override
  State<FeeView> createState() => _FeeViewState();
}

class _FeeViewState extends State<FeeView> {
  final feeController = Get.put(FeeController());

  final homeController = Get.put(HomeController());

  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));

  Future<void> _pullRefresh() async {

    setState(() {
      feeController.feeList(homeController.token.value);
    });
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryAppBar(
            isPrefix: true,
            title: "feeStudent".tr,
            onTap: () {
              Get.back();
            },
          ),
          Obx(() {
            return feeController.isLoading.value
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
                : feeController.feeAllList.isNotEmpty
                    ? Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.02),
                            child: RefreshIndicator(
                              onRefresh: _pullRefresh,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: feeController.feeAllList.length,
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
                                                    //     borderRadius:
                                                    //         BorderRadius.circular(10),
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
                                                            child: Row(
                                                              children: [
                                                                AppText(
                                                                  title:
                                                                  "amount".tr,
                                                                  color: AppColors
                                                                      .DARK_TEXT_COLOR,
                                                                  fontFamily: Weights.semi,
                                                                  textAlign:
                                                                  TextAlign.justify,
                                                                  size: Get.height * 0.016,
                                                                ),
                                                                AppText(
                                                                  title:
                                                                      " : ${feeController.feeAllList[index].amount ?? "20"} F CFA",
                                                                  color: AppColors
                                                                      .DARK_TEXT_COLOR,
                                                                  fontFamily: Weights.semi,
                                                                  textAlign:
                                                                      TextAlign.justify,
                                                                  size: Get.height * 0.016,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [

                                                              AppText(
                                                                title: feeController
                                                                        .feeAllList[
                                                                            index]
                                                                        .status ??
                                                                    "",
                                                                color: feeController
                                                                            .feeAllList[
                                                                                index]
                                                                            .status ==
                                                                        "pending"
                                                                    ? Colors.red
                                                                    : Colors.green,
                                                                fontFamily:
                                                                    Weights.semi,
                                                                size:
                                                                    Get.height * 0.016,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: DateFormat('dd MMM yyyy')
                                                        .format(
                                                      feeController
                                                          .feeAllList[index].date,
                                                    ),
                                                    color:
                                                    feeController
                                                        .feeAllList[
                                                    index]
                                                        .status ==
                                                        "pending"?   Colors.red:Colors.green,
                                                    fontFamily: Weights.semi,
                                                    size: Get.height * 0.016,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.4,
                          ),
                          Center(
                              child: AppText(
                            title:"No Fees".tr,
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
