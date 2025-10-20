import 'package:get/get.dart';

import '../controllers/method_pembayaran_controller.dart';

class MethodPembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MethodPembayaranController>(
      () => MethodPembayaranController(),
    );
  }
}
