import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_button.dart';

Widget buildBottomPicker(Widget picker) {
  var size = Get.size;
  return Container(
    height: size.height * 0.4,
    width: size.width,
    padding: const EdgeInsets.only(top: 6.0),
    decoration: const BoxDecoration(
      color: CupertinoColors.white,
    ),
    child: Column(
      children: [
        Expanded(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: CupertinoColors.black,
              fontSize: 22.0,
            ),
            child: GestureDetector(
              // Blocks taps from propagating to the modal sheet and popping.
              onTap: () {},
              child: SafeArea(
                top: false,
                child: picker,
              ),
            ),
          ),
        ),
        Material(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppButton(
            buttonName: "Done".tr,
            buttonRadius: BorderRadius.circular(10),
            textColor: AppColors.WHITE_COLOR,
            onTap: () {
              Get.back();
            },
            buttonColor: AppColors.primaryColor,
          ),
        ))
      ],
    ),
  );
}
