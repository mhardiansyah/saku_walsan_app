import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  var name = ''.obs;
  var email = ''.obs;
  var username = ''.obs;
  var password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    name.value = box.read('name') ?? 'Unknown User';
    email.value = box.read('email') ?? 'No Email';
    username.value = box.read('username') ?? 'No Username';
    password.value = '********';
  }

  void logout() {
    box.erase(); // hapus semua data login
    Get.snackbar(
      'Logout',
      'Anda telah logout',
      snackPosition: SnackPosition.BOTTOM,
    );
    // Arahkan ke halaman login
    // Get.offAllNamed(Routes.LOGIN);
  }
}
