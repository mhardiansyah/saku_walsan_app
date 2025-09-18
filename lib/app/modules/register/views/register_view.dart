// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saku_walsan_app/app/modules/register/controllers/regsiter_controller.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA), // Sama seperti LoginView
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset('assets/icons/logo.png', height: 72),
                  SizedBox(height: 32),

                  // Title
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),

                  // Subtitle
                  Text(
                    'Selamat datang di SakuWali',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 32),

                  // Name Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Name Field
                  Obx(
                    () => TextField(
                      onChanged: (value) => controller.name.value = value,
                      decoration: InputDecoration(
                        hintText: "Masukan Nama Anda",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        errorText: controller.nameError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF), // Sama seperti LoginView
                      ),
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Email Label
                  Align(
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

                  // Email Field
                  Obx(
                    () => TextField(
                      onChanged: (value) => controller.email.value = value,
                      decoration: InputDecoration(
                        hintText: "Masukan Email Anda",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        errorText: controller.emailError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Password Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Password Field
                  Obx(
                    () => TextField(
                      onChanged: (value) => controller.password.value = value,
                      obscureText: controller.isPasswordHidden.value,
                      decoration: InputDecoration(
                        hintText: "Masukan Password Anda",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        errorText: controller.passwordError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[700],
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Confirm Password Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Confirm Password Field
                  Obx(
                    () => TextField(
                      onChanged:
                          (value) => controller.confirmPassword.value = value,
                      obscureText: controller.isConfirmPasswordHidden.value,
                      decoration: InputDecoration(
                        hintText: "Masukan Konfirmasi Password",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        errorText: controller.confirmPasswordError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[700],
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1B8A4E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (controller.validateForm()) {
                          controller.register();
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sudah punya akun? silahkan ",
                        style: TextStyle(color: Colors.black87),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.orange,
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
      ),
    );
  }
}