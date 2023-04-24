import 'package:geolokasi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changePage(int i) async {
    //pageIndex.value = i;
    print(i);
    switch (i) {
      case 1:
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE_PAGE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }
}
