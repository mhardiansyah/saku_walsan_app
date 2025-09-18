import 'package:get/get.dart';

import '../controllers/isi_data_siswa_controller.dart';

class IsiDataSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IsiDataSiswaController>(
      () => IsiDataSiswaController(),
    );
  }
}
