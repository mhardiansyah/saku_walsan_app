import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart' show Routes;
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA), // Light background
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
                    'Log In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),

                  // Subtitle
                  Text(
                    "Selamat datang di SakuWali",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 32),

                  // Email Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Username",
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
                      onChanged: (value) => controller.username.value = value,
                      decoration: InputDecoration(
                        hintText: "Masukan Username Anda",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        errorText: controller.usernameError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF), // Light field
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 20),

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
                        fillColor: Color(0xFFFFFFFF), // Light field
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
                  SizedBox(height: 10),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? () {} // tombol tetap aktif tapi gak bisa di-tap
                            : controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B8A4E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBackgroundColor: Color(0xFF1c7846),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Log In",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum Punya akun? silahkan ",
                        style: TextStyle(color: Colors.black87),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.REGISTER),
                        child: Text(
                          "Sign Up",
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
