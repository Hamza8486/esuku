// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Profile/Component/curve_path.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Loader/loader.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_text.dart';
import 'package:suku/Utils/bottom_sheet.dart';

class ProfileView extends StatefulWidget {
   ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final homeController = Get.put(HomeController());

  File ? _file;
  var token = "";

  String marks = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperFunctions.getFromPreference("token").then((value) {
      token = value;
      homeController.homeList(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
      body: Obx(
        () {
          return
            homeController.isLoading.value
                ? Column(
              children: [
                SizedBox(
                  height: Get.height * 0.55,
                ),
                Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )),
              ],
            )
                :

            Column(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  width: size.width,
                  color: AppColors.primaryColor,
                  height: size.height * 0.5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_new_sharp,
                                    color: AppColors.WHITE_COLOR,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width*0.3,),
                            AppText(
                                title: "Pro".tr,
                                color: AppColors.WHITE_COLOR,
                                fontFamily: Weights.semi,
                                size: size.height * 0.02),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.13,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (builder) =>
                                      bottomSheet(onCamera: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(
                                            ImageSource.camera)
                                            .then((value) {
                                          setState(() {
                                            _file = value!;
                                            appLoader(context, AppColors.primaryColor);
                                            ApiManger().editProfile(image: value,token: token);
                                          });
                                        });
                                      }, onGallery: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(
                                            ImageSource.gallery)
                                            .then((value) {
                                          setState(() {
                                            _file = value!;
                                            appLoader(context, AppColors.primaryColor);
                                            ApiManger().editProfile(image: value,token: token);
                                          });
                                        });
                                      }));
                            },
                            child:
                                _file != null?
                            Container(
                                height: Get.height*0.14,
                                width: Get.height*0.14,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryColor),
                                  shape: BoxShape.circle,
                                ),
                                child:
                                     ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(100),
                                  child: Image.file(
                                    _file as File,
                                    fit: BoxFit.cover,
                                  ),
                                )):Container(
                                    height: Get.height*0.14,
                                    width: Get.height*0.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.WHITE_COLOR),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      child: Image.network(
                                        homeController.homeModel?.image??"",
                                        fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, exception,
                                              stackTrace) {
                                            return ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              child: Image.asset(
                                                "assets/persons.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          }
                                      ),
                                    )
                                ),

                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Center(
                          child: AppText(
                              title: "${homeController.homeModel?.firstName??""} ${homeController.homeModel?.lastName??""}",
                              color: AppColors.WHITE_COLOR,
                              fontFamily: Weights.semi,
                              size: size.height * 0.023),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.02,),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.01),
                child: Row(
                  children: [
                Icon(Icons.school,size: Get.height*0.032,),
    SizedBox(width: Get.width*0.03,),
    AppText(
    title: homeController.homeModel?.school?.name??"",
    color: AppColors.DARK_TEXT_COLOR,
    fontFamily: Weights.semi,
          size: Get.height*0.017,

    ),
                  ],
                ),
              ),
              Divider(color: AppColors.primaryColor.withOpacity(0.5),),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.01),
                child: Row(
                  children: [
                    Icon(Icons.flight_class,size: Get.height*0.032,),
                    SizedBox(width: Get.width*0.03,),
                    AppText(
                      title:"${homeController.homeModel?.homeClass?.name??""} ${homeController.homeModel?.section?.name??""}",
                      color: AppColors.DARK_TEXT_COLOR,
                      fontFamily: Weights.semi,
                      size: Get.height*0.017,

                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.primaryColor.withOpacity(0.5),),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.01),
                child: Row(
                  children: [
                    Icon(Icons.email,size: Get.height*0.032,),
                    SizedBox(width: Get.width*0.03,),
                    AppText(
                      title:homeController.homeModel?.email??"",
                      color: AppColors.DARK_TEXT_COLOR,
                      fontFamily: Weights.semi,
                      size: Get.height*0.017,

                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.primaryColor.withOpacity(0.5),),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.01),
                child: Row(
                  children: [
                    Icon(Icons.call,size: Get.height*0.032,),
                    SizedBox(width: Get.width*0.03,),
                    AppText(
                      title: homeController.homeModel?.phone??"",
                      color: AppColors.DARK_TEXT_COLOR,
                      fontFamily: Weights.semi,
                      size: Get.height*0.017,

                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.primaryColor.withOpacity(0.5),),

            ],
          );
        }
      ),
    );
  }
}
