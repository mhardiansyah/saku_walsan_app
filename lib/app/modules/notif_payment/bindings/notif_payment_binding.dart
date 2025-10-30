import 'package:get/get.dart';

import '../controllers/notif_payment_controller.dart';

class NotifPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifPaymentController>(
      () => NotifPaymentController(),
    );
  }
}
