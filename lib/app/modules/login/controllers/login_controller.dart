// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saku_walsan_app/app/core/models/santri_models.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  // Reactive variables for email and password
  var username = ''.obs;
  var password = ''.obs;

  // Reactive variables for error messages
  var usernameError = RxnString();
  var passwordError = RxnString();

  // Reactive variable for loading state
  var isLoading = false.obs;

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
    usernameError.value = null;
    passwordError.value = null;

    if (username.value.isEmpty) {
      usernameError.value = 'Email tidak boleh kosong';
      isValid = false;
    } else if (!GetUtils.isUsername(username.value)) {
      usernameError.value = 'Format username tidak valid';
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
    username.value = '';
    password.value = '';
    usernameError.value = null;
    passwordError.value = null;
  }

  void login() async {
    if (validateForm()) {
      try {
        isLoading.value = true;
        Uri urlLogin = Uri.parse('${url}/auth/login-walsan/');
        var body = jsonEncode({
          'username': username.value,
          'password': password.value,
          'role': 'Walisantri',
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
          // box.write('access_token', data['access_token']);
          // box.write('name', data['name'] ?? '');
          // box.write('email', data['email'] ?? '');
          // if (data['parent'] != null &&
          //     data['parent']['santri'] != null &&
          //     data['parent']['santri'].isNotEmpty) {
          //   final santriId = data['parent']['santri'][0]['id'];
          //   box.write('santriId', santriId);
          //   print('Santri ID: $santriId');
          // }
          box.write('access_token', data['access_token']?.toString() ?? '');
          box.write('refresh_token', data['refresh_token']?.toString() ?? '');
          box.write('name', data['name']?.toString() ?? '');
          box.write('username', data['username']?.toString() ?? '');

          // if (data['parent']?['santri'] != null &&
          //     (data['parent']['santri'] as List).isNotEmpty) {
          //   final santriId =
          //       data['parent']['santri'][0]['id']?.toString() ?? '';
          //   box.write('santriId', santriId);
          // }

          if (data['parent']?['santri'] != null &&
              (data['parent']['santri'] as List).isNotEmpty) {
            final santriId = data['parent']['santri'][0]['id'] ?? 0;
            box.write('santriId', santriId); // simpan sebagai int
          }

          // print('santriId: ${box.read('santriId')}');
          // print('access_token: ${box.read('access_token')}');

          print("Decoded data: $data");
          print("access_token: ${data['access_token']}");
          print("name: ${data['name']}");
          print("email: ${data['email']}");

          Get.snackbar(
            'Login',
            'Login berhasil!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(Routes.MAIN_NAVIGATION);
        } else {
          Get.snackbar(
            'Login',
            data['message'] ?? 'Email atau password salah!',
          );
        }
      } catch (e) {
        Get.snackbar('Login', 'Terjadi kesalahan: $e');
        print('Error during login: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
        'Error',
        'Silakan perbaiki kesalahan di login',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
