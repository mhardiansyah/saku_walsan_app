import 'package:get/get.dart';

import '../controllers/riwayat_transaksi_controller.dart';

class RiwayatTransaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatTransaksiController>(
      () => RiwayatTransaksiController(),
    );
  }
}
