// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Component/marks.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Component/subject_marks.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Controller/mark_controller.dart';
import 'package:suku/AppModule/HomeFeatures/TimeTable/Component/today_time.dart';
import 'package:suku/AppModule/HomeFeatures/TimeTable/Component/week_time.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Constants/strings.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';

class MarksView extends StatefulWidget {
  const MarksView({Key? key}) : super(key: key);

  @override
  _MarksViewState createState() => _MarksViewState();
}

class _MarksViewState extends State<MarksView>
    with SingleTickerProviderStateMixin {

  final markController = Get.put(MarkController());
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
              title: "mark".tr,
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
                Tab(text: "Last Marks".tr),

                  Tab(text: "Marks by Subject".tr),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Marks(),
                  SubjectMarks(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
