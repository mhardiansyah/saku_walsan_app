import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: const BoxDecoration(
                color: Color(0xFF2EAF66),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar bulat oranye
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFFFFB800),
                    child: Icon(Icons.person, color: Colors.white, size: 50),
                  ),
                  const SizedBox(height: 15),

                  // Nama pengguna
                  const Text(
                    "Rahsya Aditiya",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ===== FORM PROFIL =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama
                  const Text(
                    "Nama:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => _buildField(
                      controller.name.value,
                      isBold: true,
                      backgroundColor: const Color(0xFFF3F1F1),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Email
                  const Text(
                    "Email:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => _buildField(
                      controller.email.value,
                      backgroundColor: const Color(0xFFF9F9F9),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Password
                  // Password
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Password text
                          Text(
                            controller.isPasswordHidden.value
                                ? '********'
                                : controller.password.value,
                            style: const TextStyle(fontSize: 15),
                          ),

                          // Visibility icon
                          GestureDetector(
                            onTap: controller.togglePasswordVisibility,
                            child: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ===== TOMBOL LOGOUT =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8A8A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Color(0xFFED1C24),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget field untuk nama & email
  Widget _buildField(
    String value, {
    bool isBold = false,
    Color backgroundColor = Colors.white,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
