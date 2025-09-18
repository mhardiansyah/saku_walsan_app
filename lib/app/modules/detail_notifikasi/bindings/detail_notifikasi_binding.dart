import 'package:get/get.dart';

import '../controllers/detail_notifikasi_controller.dart';

class DetailNotifikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNotifikasiController>(
      () => DetailNotifikasiController(),
    );
  }
}
