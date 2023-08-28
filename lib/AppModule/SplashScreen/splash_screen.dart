// ignore_for_file: must_call_super, prefer_const_constructors

import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suku/AppModule/Authentication/Login/View/login_view.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/Home/View/home_view.dart';
import 'package:suku/Services/helper_function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userID = "";
  String token = "";
  String TYPE = "";

  @override
  void initState() {
    super.initState();
    HelperFunctions.getFromPreference("type").then((value) {
      setState(() {
        TYPE = value;
        Get.put(HomeController()).updateTypeId(TYPE.toString());
      });

      debugPrint(TYPE);
      debugPrint(TYPE);
    });

    HelperFunctions.getFromPreference("userId").then((value) {
      setState(() {
        userID = value;
        Get.put(HomeController()).updateStudentId(userID.toString());
      });

      debugPrint(userID);
      debugPrint(userID);
      moveToNext();
    });
  }

  void moveToNext() {
    Future.delayed(Duration(seconds: 3), () {
      debugPrint('In Next Screen');
      if (userID != null && userID != "") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return HomeView();
            },
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return LoginView();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width * 0.35,
            child: FlareActor(
              "assets/school spleash.flr",
              animation: "start",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
