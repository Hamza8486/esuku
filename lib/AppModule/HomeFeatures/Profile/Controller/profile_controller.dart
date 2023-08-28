import 'package:get/get.dart';
import 'package:suku/Services/helper_function.dart';

class ProfileController extends GetxController {
  var name = "".obs;
  var last = "".obs;
  var userId = "".obs;
  var type = "".obs;
  var schoolCode = "".obs;
  var classId = "".obs;
  var secId = "".obs;
  var rollNo = "".obs;
  var gender = "".obs;
  var birth = "".obs;
  var city = "".obs;
  var email = "".obs;
  var parentName = "".obs;
  var phone = "".obs;
  var address = "".obs;
  var password = "".obs;
  var token = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    HelperFunctions.getFromPreference("userId").then((value) {
      userId.value = value;
      update();
    });
    HelperFunctions.getFromPreference("type").then((value) {
      type.value = value;
      update();
    });
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
    });

    HelperFunctions.getFromPreference("schoolCode").then((value) {
      schoolCode.value = value;
      update();
    });

    HelperFunctions.getFromPreference("classId").then((value) {
      classId.value = value;
      update();
    });

    HelperFunctions.getFromPreference("secId").then((value) {
      secId.value = value;
      update();
    });

    HelperFunctions.getFromPreference("roll").then((value) {
      rollNo.value = value;
      update();
    });

    HelperFunctions.getFromPreference("name").then((value) {
      name.value = value;
      update();
    });

    HelperFunctions.getFromPreference("last").then((value) {
      last.value = value;
      update();
    });

    HelperFunctions.getFromPreference("gender").then((value) {
      gender.value = value;
      update();
    });

    HelperFunctions.getFromPreference("birth").then((value) {
      birth.value = value;
      update();
    });

    HelperFunctions.getFromPreference("address").then((value) {
      address.value = value;
      update();
    });

    HelperFunctions.getFromPreference("city").then((value) {
      city.value = value;
      update();
    });

    HelperFunctions.getFromPreference("phone").then((value) {
      phone.value = value;
      update();
    });

    HelperFunctions.getFromPreference("email").then((value) {
      email.value = value;
      update();
    });

    HelperFunctions.getFromPreference("parentName").then((value) {
      parentName.value = value;
      update();
    });

    HelperFunctions.getFromPreference("password").then((value) {
      password.value = value;
      update();
    });
  }
}
