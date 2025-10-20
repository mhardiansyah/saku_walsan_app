import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saku_walsan_app/app/core/models/berita_models.dart';

class DetailBeritaController extends GetxController {
  BeritaRespose? berita;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is BeritaRespose) {
      berita = Get.arguments as BeritaRespose;
      print(" Data berita diterima: ${berita?.title.rendered}");
    } else {
      print("Tidak ada data berita yang dikirim");
    }
  }
}
