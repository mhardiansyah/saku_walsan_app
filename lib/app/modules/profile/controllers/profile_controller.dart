import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = 'Faqih Abqory'.obs;
  var email = 'SitiM@gmail.com'.obs;
  var password = '********'.obs;

  void logout() {
    // Aksi logout di sini
    Get.snackbar('Logout', 'Anda telah logout',
        snackPosition: SnackPosition.BOTTOM);
  }
}
