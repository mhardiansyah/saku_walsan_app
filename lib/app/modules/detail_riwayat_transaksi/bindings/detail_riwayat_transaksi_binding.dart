import 'package:get/get.dart';

import '../controllers/detail_riwayat_transaksi_controller.dart';

class DetailRiwayatTransaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRiwayatTransaksiController>(
      () => DetailRiwayatTransaksiController(),
    );
  }
}
