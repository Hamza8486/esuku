// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class LeaveController extends GetxController {
  var isLoading = false.obs;
  var leaveAllList = [].obs;
  var token = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
      leaveList(token.value);
    });
  }

  leaveList(var tokenValue) async {
    try {
      isLoading(true);

      var workData = await ApiManger.leaveResp(token: tokenValue);
      if (workData != null) {
        leaveAllList.value = workData.leaves;
      } else {
        print(workData?.leaves.length);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
