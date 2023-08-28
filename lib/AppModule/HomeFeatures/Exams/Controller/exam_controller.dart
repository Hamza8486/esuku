// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class ExamController extends GetxController {
  var isLoading = false.obs;
  var examAllList = [].obs;
  var token = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
      examList(token.value);
    });
  }

  examList(var tokenValue) async {
    try {
      isLoading(true);

      var examData = await ApiManger.examResp(token: tokenValue);
      if (examData != null) {
        examAllList.value = examData.exams;

      } else {
        print(examData?.exams.length);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
