import 'package:get/get.dart';
import 'package:saku_walsan_app/app/core/models/berita_models.dart';

class DetailBeritaController extends GetxController {
  late BeritaRespose berita;
  //TODO: Implement DetailBeritaController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    berita = Get.arguments as BeritaRespose;
    print("berita: $berita");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
