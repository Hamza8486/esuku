// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class DashboardCard extends StatelessWidget {
  final String name;

  final String imgpath;

  const DashboardCard({Key? key, required this.name, required this.imgpath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Container(
        height: height * 0.16,
        width: width * 0.30,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.Border_COLOR, width: 1.4),
          borderRadius: BorderRadius.circular(20),
          color: AppColors.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Image.asset(
              "assets/$imgpath",
              width: 50,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, left: 5, right: 5, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.WHITE_COLOR,
                    border: Border.all(
                        color: AppColors.Border_COLOR.withOpacity(0.5))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  child: AppText(
                    title: "$name",
                    size: Get.height * 0.015,
                    fontFamily: Weights.medium,
                    color: AppColors.BLACK_COLOR,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
