import 'package:get/get.dart';

import '../controllers/winpay_history_controller.dart';

class WinpayHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WinpayHistoryController>(
      () => WinpayHistoryController(),
    );
  }
}
