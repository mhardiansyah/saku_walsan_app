import 'package:get/get.dart';

import '../controllers/resent_password_controller.dart';

class ResentPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResentPasswordController>(
      () => ResentPasswordController(),
    );
  }
}
