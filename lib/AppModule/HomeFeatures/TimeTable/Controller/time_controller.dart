// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class TimeController extends GetxController {
  var isLoading = false.obs;
  var sattimeTableList = [].obs;
  var monday = [].obs;
  var tue = [].obs;
  var wed = [].obs;
  var thur = [].obs;
  var frid = [].obs;
  var sat = [].obs;
  var todayTimeTableList = [].obs;
  var token = "".obs;
  RxBool expand = false.obs;
  RxBool expand1 = false.obs;
  RxBool expand2 = false.obs;
  RxBool expand3 = false.obs;
  RxBool expand4 = false.obs;
  RxBool expand5 = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
     timeList(token.value);
    });
  }
  timeList(var tokenValue) async {
    try {
      isLoading(true);

      var timeData = await ApiManger.timeTableResp(token: tokenValue);
      if (timeData != null) {
        monday.value = timeData.monday as dynamic;
        tue.value = timeData.tuesday as dynamic;
        wed.value = timeData.wednesday as dynamic;
        thur.value = timeData.thursday as dynamic;
        frid.value = timeData.friday as dynamic;
        sat.value = timeData.saturday as dynamic;
        todayTimeTableList.value = timeData.todayTimetable as dynamic;
      } else {
        print(timeData?.monday?.length);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
