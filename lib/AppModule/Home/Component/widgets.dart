import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

Widget boxWidget({color, text, text1,borderRadius}) {
  return Row(
    children: [
      Container(
        height: Get.height*0.041,
        width: Get.height*0.042,
        decoration: BoxDecoration(
            color: color, borderRadius: borderRadius),
        child: Center(
          child: AppText(
            title: text,
            fontFamily: Weights.medium,
            size: Get.height * 0.015,
            color: AppColors.WHITE_COLOR,
          ),
        ),
      ),
      SizedBox(
        width: 6,
      ),
      AppText(
        title: text1,
        size: Get.height * 0.0165,
        fontFamily: Weights.semi,
        color: AppColors.DARK_GREY_COLOR,
      ),
    ],
  );
}


Widget text({text}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(7)),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: AppText(
        fontFamily: Weights.semi,
        size: Get.height * 0.015,
        title: text,
        maxLines: 1,
        overFlow: TextOverflow.ellipsis,
        color: AppColors.DARK_TEXT_COLOR,
      ),
    ),
  );
}

Widget dateList({icon, name, onPress}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.WHITE_COLOR,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12,bottom: 12,right: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(
                  width: 10,
                ),
                AppText(
                  title: name,
                  size: Get.height * 0.016,
                  fontFamily: Weights.semi,
                  color: AppColors.DARK_TEXT_COLOR,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Get.height * 0.018,
            )
          ],
        ),
      ),
    ),
  );
}