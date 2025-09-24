import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saku_walsan_app/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    RxString logined = "".obs;

    Future.delayed(const Duration(seconds: 2), () {
      final token = box.read('access_token');
      if (token != null && token.isNotEmpty) {
        Get.offAllNamed(Routes.MAIN_NAVIGATION);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });

    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          // Logo di tengah
          Center(
            child: Image.asset(
              'assets/icons/logoWali.png',
              width: 320,
              height: 320,
            ),
          ),

          // Teks di bawah
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Dibuat oleh Siswa SMK MQ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
