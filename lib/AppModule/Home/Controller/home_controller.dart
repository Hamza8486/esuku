// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:suku/AppModule/Home/Model/home_model.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var token = "".obs;
  var type = "".obs;
  var id = "".obs;

  updateStudentId(val){
    id.value=val;
    update();
  }
  updateTypeId(val){
    type.value=val;
    update();
  }

  HomeModel? homeModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HelperFunctions.getFromPreference("type").then((value) {
      type.value = value;
      update();
    });
    HelperFunctions.getFromPreference("userId").then((value) {
      id.value = value;
      update();
    });
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      print(token);
      update();
      //homeList(token.value);
    });
  }

  homeList(var tokenValue) async {
    try {
      isLoading(true);

      var homeData = await ApiManger.homeResponse(token: tokenValue);
      if (homeData != null) {
        homeModel = homeData.home;
      } else {
        print(homeData?.home);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }




}
