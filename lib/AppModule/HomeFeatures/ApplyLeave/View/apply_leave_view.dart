// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';
import 'package:suku/Utils/App_Bar/app_bar.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Loader/loader.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_button.dart';
import 'package:suku/Utils/Widgets/app_field.dart';
import 'package:suku/Utils/Widgets/app_text.dart';
import 'package:suku/Utils/Widgets/date_picker.dart';

class ApplyLeaveView extends StatefulWidget {
  const ApplyLeaveView({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveView> createState() => _ApplyLeaveViewState();
}

class _ApplyLeaveViewState extends State<ApplyLeaveView> {
  DateTime timeFrom = DateTime.now();
  DateTime timeTo = DateTime.now();

  List<String> listOfValue = [
    "sick".tr,
    "medical".tr,
    "family".tr,
    "wedding".tr,
    "other".tr,
  ];

  String? _selectedValue;
  final dateController = TextEditingController();
  final reasonController = TextEditingController();
  DateTime currentDate = DateTime.now();

  String currentDateValue = "";
  String toDateValue = "";
  bool showDatePicker = false;

  String token = "";

  @override
  void initState() {
    setState(() {
      currentDateValue = dateController.text;
    });
    super.initState();
    HelperFunctions.getFromPreference("token").then((value) {
      token = value;
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryAppBar(
            title: "apply".tr,
            isPrefix: true,
            onTap: () {
              Get.back();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.014,
                    ),
                    AppText(
                      title: "selectLeaveType".tr,
                      color: AppColors.BLACK_COLOR,
                      fontFamily: Weights.medium,
                      size: Get.height * 0.018,
                    ),
                    SizedBox(
                      height: Get.height * 0.014,
                    ),
                    DropdownButtonFormField(
                      value: _selectedValue,
                      isExpanded: true,
                      iconEnabledColor: Colors.grey,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.022,
                            vertical: Get.height * 0.016),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: AppColors.BLACK_COLOR)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: AppColors.BLACK_COLOR)),
                      ),
                      hint: Text(
                        "selectLeaveType".tr,
                        style: TextStyle(
                            color: AppColors.GREY_COLOR,
                            fontFamily: Weights.regular,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value.toString();
                          print(_selectedValue);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          _selectedValue = value.toString();
                        });
                      },
                      items: listOfValue.map((String val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(
                            val,
                            style: TextStyle(
                                color: AppColors.BLACK_COLOR.withOpacity(0.7),
                                fontSize: Get.height * 0.016,
                                fontFamily: _selectedValue == null
                                    ? Weights.regular
                                    : Weights.medium),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    AppText(
                      title: "selectLeaveDate".tr,
                      color: AppColors.BLACK_COLOR,
                      fontFamily: Weights.medium,
                      size: Get.height * 0.018,
                    ),
                    SizedBox(
                      height: Get.height * 0.014,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            onTap: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return buildBottomPicker(
                                    CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      backgroundColor: Colors.white,
                                      minimumDate: currentDate,
                                      initialDateTime: currentDate,
                                      maximumDate: DateTime(2090),
                                      onDateTimeChanged:
                                          (DateTime newDateTime) {
                                        if (mounted) {
                                          debugPrint(
                                              "Your Selected Date: ${newDateTime.day}");

                                          setState(() {
                                            currentDate = newDateTime;
                                            currentDateValue =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(newDateTime)
                                                    .toString();
                                            debugPrint(currentDateValue);
                                          });
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            controller: dateController,
                            isborderline: true,
                            isReadOnly: true,
                            hintSize: Get.height * 0.014,
                            fontHint: toDateValue.isEmpty
                                ? Weights.regular
                                : Weights.semi,
                            hintColor: currentDateValue.isEmpty
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR.withOpacity(0.7),
                            isShowCursor: false,
                            borderColor: AppColors.DARK_TEXT_COLOR,
                            hint: currentDateValue.isEmpty
                                ? "Select From Date".tr
                                : currentDateValue.toString(),
                            textInputAction: TextInputAction.next,
                            borderRadius: BorderRadius.circular(10),
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05,
                                vertical: Get.height * 0.017),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.02),
                          child: AppText(
                            title: "to".tr,
                            color: AppColors.BLACK_COLOR,
                            fontFamily: Weights.medium,
                            size: Get.height * 0.018,
                          ),
                        ),
                        Expanded(
                          child: AppTextField(
                            onTap: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return buildBottomPicker(
                                    CupertinoDatePicker(

                                      mode: CupertinoDatePickerMode.date,
                                      backgroundColor: Colors.white,
                                      minimumDate: currentDate,
                                      initialDateTime: currentDate,
                                      maximumDate: DateTime(2090),
                                      onDateTimeChanged:
                                          (DateTime newDateTime) {
                                        if (mounted) {
                                          debugPrint(
                                              "Your Selected Date: ${newDateTime.day}");

                                          setState(() {
                                            currentDate = newDateTime;
                                            toDateValue =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(newDateTime)
                                                    .toString();
                                            debugPrint(toDateValue);
                                          });
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            controller: dateController,
                            isborderline: true,
                            isReadOnly: true,
                            hintColor: toDateValue.isEmpty
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR.withOpacity(0.7),
                            fontHint: toDateValue.isEmpty
                                ? Weights.regular
                                : Weights.semi,
                            isShowCursor: false,
                            hintSize: Get.height * 0.014,
                            borderColor: AppColors.DARK_TEXT_COLOR,
                            hint: toDateValue.isEmpty
                                ? "Select To Date".tr
                                : toDateValue.toString(),
                            textInputAction: TextInputAction.next,
                            borderRadius: BorderRadius.circular(10),
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05,
                                vertical: Get.height * 0.017),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    AppText(
                      title: "reason".tr,
                      color: AppColors.BLACK_COLOR,
                      fontFamily: Weights.medium,
                      size: Get.height * 0.019,
                    ),
                    SizedBox(
                      height: Get.height * 0.014,
                    ),
                    AppTextField(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03, vertical: 10),
                      maxLines: 4,
                      controller: reasonController,
                      hint: "aboutReason".tr,
                      isborderline: true,
                      borderRadius: BorderRadius.circular(10),
                      borderColor: AppColors.BLACK_COLOR,
                    ),
                    SizedBox(
                      height: Get.height * 0.3,
                    ),
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: "submit".tr,
                        textSize: Get.height * 0.018,
                        buttonColor: AppColors.primaryColor,
                        textColor: AppColors.WHITE_COLOR,
                        onTap: () {
                          if (validate()) {
                            appLoader(context, AppColors.primaryColor);
                            ApiManger.applyResponse(
                                token: token,
                                date: currentDateValue,
                                endDate: toDateValue,
                                type: _selectedValue.toString(),
                                reason: reasonController.text);
                          }
                        })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool validate() {
    if (_selectedValue == null) {
      Get.snackbar("error".tr, "selectLeaveType".tr,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM);

      return false;
    }
    if (currentDateValue.isEmpty) {
      Get.snackbar("error".tr, "selectFrom".tr,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM);

      return false;
    }
    if (toDateValue.isEmpty) {
      Get.snackbar("error".tr, "selectTo".tr,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM);

      return false;
    }
    if (reasonController.text.isEmpty) {
      Get.snackbar("error".tr, "reason".tr,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM);

      return false;
    }

    return true;
  }
}
