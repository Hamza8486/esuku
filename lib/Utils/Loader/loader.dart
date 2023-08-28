// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:suku/AppModule/Authentication/Login/View/login_view.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:suku/Services/helper_function.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

appLoader(BuildContext context, Color myColors) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            content: SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ));
}

showAlertDialog(
    {required context,
    message,
    heading,
    onTap,
    buttonAcceptTitle,
    buttonCancelTitle}) {
  // set up the buttons
  Widget cancelButton = MaterialButton(
    child: AppText(
        title: buttonCancelTitle,
        color: AppColors.DARK_TEXT_COLOR,
        fontFamily: Weights.medium),
    onPressed: () {
      Get.back();
    },
  );
  Widget continueButton = MaterialButton(
      child: AppText(
          title: buttonAcceptTitle,
          color: AppColors.primaryColor,
          fontFamily: Weights.medium),
      onPressed: onTap);

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: AppText(
        title: heading,
        fontFamily: Weights.medium,
        color: AppColors.primaryColor),
    content: AppText(
        title: message,
        fontFamily: Weights.medium,
        color: AppColors.DARK_TEXT_COLOR),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
Future<bool> showExitPopup(context,token) async{

    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              height: Get.height*0.12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Do you want to exit?".tr,style: TextStyle(color: AppColors.primaryColor,
                        fontFamily: Weights.medium
                    ),),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ApiManger.logoutResp(token: token);
                            HelperFunctions.clearPrefs();
                            Get.offAll(LoginView());
                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primaryColor),
                          child:  Text("Yes".tr,style: TextStyle(color: AppColors.WHITE_COLOR),),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child:  Text("No".tr, style: TextStyle(color: Colors.black)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });}

getShimmerAllLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
          height: Get.height * 0.11,
          width: Get.width,

        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [

              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 18.0,
                color: Colors.white,
              ),

            ],
          ),
        )
      ],
    ),
  );
}

