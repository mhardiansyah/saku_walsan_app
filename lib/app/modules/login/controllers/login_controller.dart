// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  // Reactive variables for email and password
  var email = ''.obs;
  var password = ''.obs;

  // Reactive variables for error messages
  var emailError = RxnString();
  var passwordError = RxnString();

  // Reactive variable for password visibility
  var isPasswordHidden = true.obs;
  var url = dotenv.env['base_url'];
  final box = GetStorage();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  bool validateForm() {
    bool isValid = true;

    // Reset error messages
    emailError.value = null;
    passwordError.value = null;

    if (email.value.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
      isValid = false;
    } else if (!GetUtils.isEmail(email.value)) {
      emailError.value = 'Format email tidak valid';
      isValid = false;
    }
    if (password.value.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
      isValid = false;
    } else if (password.value.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
      isValid = false;
    }

    return isValid;
  }

  void clearForm() {
    email.value = '';
    password.value = '';
    emailError.value = null;
    passwordError.value = null;
  }

  void login() async {
    if (validateForm()) {
      try {
        Uri urlLogin = Uri.parse('${url}/auth/login/');
        var body = jsonEncode({
          'email': email.value,
          'password': password.value,
          'role': 'Admin',
        });

        print('URL: $urlLogin');
        print('Body: $body');

        var response = await http.post(
          urlLogin,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        print('response.statusCode: ${response.statusCode}');
        print('response.body: ${response.body}');

        final data = json.decode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          box.write('access_token', data['access_token']);
          box.write('name', data['name']);
          box.write('email', data['email']);

          print('access_token: ${box.read('access_token')}');
          Get.snackbar('Login', 'Login berhasil!');
          Get.offAllNamed(Routes.MAIN_NAVIGATION);
        } else {
          Get.snackbar(
            'Login',
            data['message'] ?? 'Email atau password salah!',
          );
        }
      } catch (e) {
        Get.snackbar('Login', 'Terjadi kesalahan: $e');
      }
    } else {
      Get.snackbar('Error', 'Silakan perbaiki kesalahan di login');
    }
  }
}
