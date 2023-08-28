// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/AppModule/HomeFeatures/HomeWork/Component/AllHomeWork.dart';
import 'package:suku/AppModule/HomeFeatures/HomeWork/Component/TodayHomeWork.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';

class HomeWorkView extends StatefulWidget {
  const HomeWorkView({Key? key}) : super(key: key);

  @override
  _HomeWorkViewState createState() => _HomeWorkViewState();
}

class _HomeWorkViewState extends State<HomeWorkView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            PrimaryAppBar(
              isPrefix: true,
              onTap: () {
                Get.back();
              },
              title: "work".tr,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
              child: TabBar(
                labelColor: AppColors.primaryColor,
                labelStyle: TextStyle(
                    fontFamily: Weights.semi, fontSize: Get.height * 0.018),
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primaryColor,
                tabs: [
                  Tab(text: "today".tr),
                  Tab(text: "all".tr),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  TodayHomeWork(),
                  AllHomeWork(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
