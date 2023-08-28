// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Model/mark_model.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class MarkController extends GetxController {
  var isLoading = false.obs;
  var markListData = [].obs;
  var SubjectListData = [].obs;
  var token = "".obs;

  @override
  void onInit() {
    super.onInit();
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
      markList(token.value);
    });
  }

  markList(var tokenValue) async {
    try {
      isLoading(true);

      var markData = await ApiManger.markResponse(token: tokenValue);
      if (markData != null) {
        markListData.value = markData.marks as dynamic;
        SubjectListData.value = markData.subjecctMarks as dynamic;
      } else {
        print(markData?.marks?.length);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
