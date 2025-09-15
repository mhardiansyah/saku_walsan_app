import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotpasswordController extends GetxController {
  // Observables untuk email dan pesan error
  var email = ''.obs;
  var emailError = RxnString();

  // Fungsi validasi dan submit email
  void submitEmail() {
    // Validasi sederhana email
    if (email.value.isEmpty) {
      emailError.value = 'Email wajib diisi';
      return;
    }

    if (!GetUtils.isEmail(email.value)) {
      emailError.value = 'Format email tidak valid';
      return;
    }

    emailError.value = null;

    // TODO: Kirim request ke backend untuk reset password
    Get.snackbar(
      'Berhasil',
      'Link reset password telah dikirim ke ${email.value}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  // Optional override

  @override
  void onClose() {
    email.value = '';
    emailError.value = null;
    super.onClose();
  }
}
