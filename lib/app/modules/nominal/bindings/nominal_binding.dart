import 'package:get/get.dart';

import '../controllers/nominal_controller.dart';

class NominalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NominalController>(
      () => NominalController(),
    );
  }
}
