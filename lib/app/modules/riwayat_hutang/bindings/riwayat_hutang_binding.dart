import 'package:get/get.dart';

import '../controllers/riwayat_hutang_controller.dart';

class RiwayatHutangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatHutangController>(
      () => RiwayatHutangController(),
    );
  }
}
