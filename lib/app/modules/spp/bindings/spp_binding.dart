import 'package:get/get.dart';

import '../controllers/spp_controller.dart';

class SppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SppController>(() => SppController());
  }
}
