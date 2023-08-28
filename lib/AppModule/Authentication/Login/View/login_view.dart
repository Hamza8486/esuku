// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';
import 'package:suku/Utils/Fonts/app_fonts.dart';
import 'package:suku/Utils/Loader/loader.dart';
import 'package:suku/Utils/Theme/app_colors.dart';
import 'package:suku/Utils/Widgets/app_button.dart';
import 'package:suku/Utils/Widgets/app_field.dart';
import 'package:suku/Utils/Widgets/app_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isUserVisible = true;
  bool _isChecked = false;

  String ? token;
  void getToken() async{
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    HelperFunctions.saveInPreference("token", token!);
    print("token");
    print(token);
  }



  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * .06,
              ),
              SizedBox(
                height: size.height * .24,
              ),
              AppText(
                title: "login".tr,
                size: 22,
                color: AppColors.DARK_TEXT_COLOR,
                fontFamily: Weights.semi,
              ),
              SizedBox(
                height: size.height * .003,
              ),
              AppText(
                title: "signIn".tr,
                size: Get.height * 0.017,
                color: AppColors.DARK_TEXT_COLOR,
                fontFamily: Weights.medium,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: size.height * .06,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  title: "name".tr,
                  color: AppColors.DARK_TEXT_COLOR,
                  size: Get.height * 0.016,
                  fontFamily: Weights.medium,
                ),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              AppTextField(
                controller: nameController,
                maxLines: 1,
                isPrefix: true,
                prefixIcon: Icon(
                  Icons.person,
                  color: AppColors.DARK_TEXT_COLOR.withOpacity(0.7),
                ),
                fontFamily: Weights.medium,
                hintSize: Get.height * 0.0155,
                isborderline: true,
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                borderColor: AppColors.DARK_TEXT_COLOR.withOpacity(0.5),
                hint: "name".tr,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                borderRadius: BorderRadius.circular(10),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  title: "password".tr,
                  color: AppColors.DARK_TEXT_COLOR,
                  size: Get.height * 0.016,
                  fontFamily: Weights.medium,
                ),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              AppTextField(
                obsecure: isUserVisible,
                isPrefix: true,
                prefixIcon: Icon(
                  Icons.lock,
                  color: AppColors.DARK_TEXT_COLOR.withOpacity(0.7),
                ),
                maxLines: 1,
                isVisible: true,
                fontFamily: Weights.medium,
                hintSize: Get.height * 0.0155,
                isborderline: true,
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                borderColor: AppColors.DARK_TEXT_COLOR.withOpacity(0.5),
                hint: "password".tr,
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                borderRadius: BorderRadius.circular(10),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isUserVisible = !isUserVisible;
                    });
                  },
                  child: Icon(
                      isUserVisible ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: AppColors.GREY_COLOR),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Theme(
                      data: ThemeData(
                          unselectedWidgetColor: AppColors.primaryColor // Your color
                      ),
                      child: Checkbox(
                          activeColor: AppColors.primaryColor,
                          value: _isChecked,
                          onChanged: (val){
                            handleRemeberme(val!);
                          }),
                    )),
                SizedBox(width: 10.0),
                Text("Remember Me",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                        fontFamily: Weights.semi))
              ]),
              SizedBox(
                height: size.height * .03,
              ),
              AppButton(
                  buttonRadius: BorderRadius.circular(10),
                  buttonWidth: Get.width,
                  fontFamily: Weights.semi,
                  textSize: Get.height * 0.02,
                  buttonName: "login".tr,
                  buttonColor: AppColors.primaryColor,
                  textColor: AppColors.WHITE_COLOR,
                  onTap: () {
                    if (validate()) {
                      appLoader(context, AppColors.primaryColor);
                      ApiManger().loginResponse(
                          name: nameController.text,
                          password: passwordController.text,
                      token: token
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    if (nameController.text.isEmpty) {
      Get.snackbar("error".tr, "nameRequired".tr,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM);

      return false;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar("error".tr, "passRequired".tr,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM);

      return false;
    }
    return true;
  }

  void handleRemeberme(bool value) {
    print("Handle Rember Me");
    _isChecked = value;
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', nameController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        nameController.text = _email;
        passwordController.text = _password ;
      }
    } catch (e) {
      print(e);
    }
  }
}


