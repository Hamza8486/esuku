// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';


  Widget DrawerListTile({icon,name,ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.013,horizontal: 10),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: Get.width * 0.04,
            ),
            AppText(
              title: "$name",
              size: Get.height * 0.018,
              color: AppColors.WHITE_COLOR,
              fontFamily: Weights.medium,
            )
          ],
        ),
      ),
    );
  }

