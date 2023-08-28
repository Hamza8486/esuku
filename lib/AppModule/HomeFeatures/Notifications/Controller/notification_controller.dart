// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notificationList = [].obs;
  var token = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
      notiList(token.value);
    });
  }

  notiList(var tokenValue) async {
    try {
      isLoading(true);

      var notiData = await ApiManger.notificationResponse(token: tokenValue);
      if (notiData != null) {
        notificationList.value = notiData.notifications;
      } else {
        print(notiData?.notifications.length);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
