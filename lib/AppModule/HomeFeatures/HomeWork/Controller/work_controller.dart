// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class WorkController extends GetxController {
  var isLoading = false.obs;
  var homeWorkList = [].obs;
  var todayWorkList = [].obs;
  var token = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
      workList(token.value);
    });
  }

  workList(var tokenValue) async {
    try {
      isLoading(true);

      var workData = await ApiManger.homeWorkResp(token: tokenValue);
      if (workData != null) {
        homeWorkList.value = workData.homework;
        todayWorkList.value = workData.todayHomework;
      } else {
        print(workData?.homework.length);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
