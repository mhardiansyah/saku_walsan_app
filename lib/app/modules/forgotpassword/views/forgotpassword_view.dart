import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saku_walsan_app/app/modules/forgotpassword/controllers/forgotpassword_controller.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class ForgotpasswordView extends GetView<ForgotpasswordController> {
  const ForgotpasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA), // Sama seperti LoginView
      body: SafeArea(
        child: Stack(
          children: [
            // Tombol Back
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Get.back(),
                tooltip: 'Back',
              ),
            ),

            // Form di tengah
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // Logo
                      Image.asset(
                        'assets/icons/logomysaku.png',
                        height: 72, // Sesuaikan tinggi logo dengan LoginView
                      ),
                      const SizedBox(height: 32),

                      // Title
                      const Text(
                        'Lupa Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Subtitle
                      Text(
                        "Masukan Email Anda",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email Label
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Email Field
                      Obx(
                        () => TextField(
                          onChanged: (value) => controller.email.value = value,
                          decoration: InputDecoration(
                            hintText: "Masukan Email Anda",
                            hintStyle: const TextStyle(color: Colors.grey),
                            errorText: controller.emailError.value,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF), // Field terang seperti LoginView
                          ),
                          style: const TextStyle(color: Colors.black87),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: controller.submitEmail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B8A4E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Kirim",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Klik disini untuk ",
                            style: TextStyle(color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.LOGIN),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xFF1B8A4E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}