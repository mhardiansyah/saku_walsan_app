import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  var name = ''.obs;
  var email = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var isPasswordHidden = true
      .obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    name.value = box.read('name') ?? 'Unknown User';
    email.value = box.read('email') ?? 'No Email';
    username.value = box.read('username') ?? 'No Username';
    password.value = box.read('password') ?? '********';
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void logout() {
    box.erase();
    Get.snackbar(
      'Logout',
      'Anda telah logout',
      snackPosition: SnackPosition.TOP,
    );
    Get.offAllNamed(Routes.LOGIN);
  }
}
