import 'package:get/get.dart';
import 'package:suku/Services/api_manager.dart';
import 'package:suku/Services/helper_function.dart';

class AttendenceListController extends GetxController {
  var attendenceList = [].obs;
  var late = 0.obs;
  var exit = 0.obs;
  var present = 0.obs;
  var leaves = 0.obs;
  var absent = 0.obs;
  var monday = [].obs;
  var tue = [].obs;
  var wed = [].obs;
  var thur = [].obs;
  var frid = [].obs;
  var sat = [].obs;
  var attendenceTodayList = [].obs;
  var token = "".obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      update();
      attendenceListAll(token.value);
    });
  }

  attendenceListAll(var token) async {
    try {
      isLoading(true);

      var attendenceData = await ApiManger.attendenceResponse(token: token);
      if (attendenceData != null) {
        monday.value = attendenceData.monday as dynamic;
        tue.value = attendenceData.tuesday as dynamic;
        wed.value = attendenceData.wednesday as dynamic;
        thur.value = attendenceData.thursday as dynamic;
        frid.value = attendenceData.friday as dynamic;
        sat.value = attendenceData.saturday as dynamic;
        late.value = attendenceData.lates ??0;
        absent.value = attendenceData.absents ??0;
        present.value = attendenceData.presents ??0;
        exit.value = attendenceData.exits ??0;
        leaves.value = attendenceData.leaves??0;
        print(attendenceData.monday?.length);
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
