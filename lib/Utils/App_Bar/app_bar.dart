// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class PrimaryAppBar extends StatelessWidget {
  PrimaryAppBar(
      {Key? key,
      this.title = "",
      this.leading = "",
      this.onTap,
      this.icon,
      this.isIcon = false,
      this.isPrefix = false,
      this.isSuffix = false,
      this.onTaps})
      : super(key: key);
  final String title;
  final String leading;
  final VoidCallback? onTap;
  final VoidCallback? onTaps;
  final bool isPrefix;
  final bool isSuffix;
  final Icon? icon;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      color: AppColors.primaryColor.withOpacity(0.9),
      elevation: 2,
      child: Container(

        width: size.width,
        height: size.height / 8.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
              child: Row(
                mainAxisAlignment:
                    isPrefix ? MainAxisAlignment.start : MainAxisAlignment.start,
                children: [
                  isPrefix
                      ? InkWell(
                          onTap: onTap,
                          child: isIcon
                              ? icon
                              : Icon(
                                  Icons.arrow_back_ios_new_sharp,
                                  size: Get.height * 0.023,
                                  color: AppColors.WHITE_COLOR,
                                ))
                      : Container(),
                  isPrefix
                      ? SizedBox(
                          width: size.width * 0.07,
                        )
                      : Container(),
                  AppText(
                      title: title,
                      size: size.height * 0.02,
                      color: AppColors.WHITE_COLOR,
                      fontFamily: Weights.semi),
                  isSuffix
                      ? InkWell(
                          onTap: onTaps,
                          child: Icon(
                            Icons.notification_important_rounded,
                            color: AppColors.WHITE_COLOR,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
