// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Notifications/Controller/notification_controller.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class NotificationView extends StatefulWidget {
  NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final notificationController = Get.put(NotificationController());

  final homeController = Get.put(HomeController());
  Future<void> _pullRefresh() async {

    setState(() {
      notificationController.notiList(notificationController.token.value);
    });
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }


  Color randomColor() => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(100), Random().nextInt(200));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryAppBar(
            isPrefix: true,
            title: "notification".tr,
            onTap: () {
              Get.back();
            },
          ),
          Obx(() {
            return notificationController.isLoading.value
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
                : notificationController.notificationList.isNotEmpty
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
                                  itemCount: notificationController
                                      .notificationList.length,
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
                                                    Expanded(
                                                      child: Padding(
                                                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.016),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                      bottom: 8.0,right: 10),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    homeController
                                                                            .homeModel?.school?.name ??
                                                                        "School Name",
                                                                    style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight:
                                                                          FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  AppText(
                                                                    title: DateFormat('dd MMM yyyy')
                                                                        .format(
                                                                      notificationController
                                                                          .notificationList[index]
                                                                          .createdAt,
                                                                    ),
                                                                    color:
                                                                    AppColors.DARK_TEXT_COLOR,
                                                                    fontFamily: Weights.medium,
                                                                    size: Get.height * 0.015,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Get.width*0.9,

                                                              child: Text(
                                                                notificationController
                                                                        .notificationList[
                                                                            index]
                                                                        .notification ??
                                                                    "notification",
                                                                maxLines: 20,
                                                                textAlign: TextAlign.start,
                                                                style: TextStyle(
                                                                    fontSize: 13,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontFamily:
                                                                        Weights.medium),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
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
                            )),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.4,
                          ),
                          Center(
                              child: AppText(
                            title:"No Notification".tr,
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
