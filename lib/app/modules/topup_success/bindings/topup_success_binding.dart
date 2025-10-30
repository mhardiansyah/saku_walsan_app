import 'package:get/get.dart';

import '../controllers/topup_success_controller.dart';

class TopupSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopupSuccessController>(
      () => TopupSuccessController(),
    );
  }
}
