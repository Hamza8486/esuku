// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class FeeController extends GetxController {
  var isLoading = false.obs;
  var feeAllList = [].obs;
  var token = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
      feeList(token.value);
    });
  }

  feeList(var tokenValue) async {
    try {
      isLoading(true);

      var workData = await ApiManger.feeResp(token: tokenValue);
      if (workData != null) {
        feeAllList.value = workData.fees;
      } else {
        print(workData?.fees.length);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
