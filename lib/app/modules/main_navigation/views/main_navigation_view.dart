// ignore_for_file: override_on_non_overriding_member, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saku_walsan_app/app/modules/home/controllers/home_controller.dart';
import 'package:saku_walsan_app/app/modules/home/views/home_view.dart';
import 'package:saku_walsan_app/app/modules/main_navigation/controllers/main_navigation_controller.dart';
import 'package:saku_walsan_app/app/modules/profile/views/profile_view.dart';
import 'package:saku_walsan_app/app/modules/riwayat_transaksi/controllers/riwayat_transaksi_controller.dart';
import 'package:saku_walsan_app/app/modules/riwayat_transaksi/views/riwayat_transaksi_view.dart';
import 'package:saku_walsan_app/app/modules/riwayat_hutang/views/riwayat_hutang_view.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class MainNavigationView extends GetView<MainNavigationController> {
  MainNavigationView({super.key});

  @override
  final pages = [
    HomeView(),
    RiwayatTransaksiView(),
    SizedBox(), // Placeholder for Top up
    RiwayatHutangView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController());
    }

    if (!Get.isRegistered<RiwayatTransaksiController>()) {
      Get.put(RiwayatTransaksiController());
    }

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            body: pages[controller.selectedIndex.value],
            backgroundColor: Colors.white,
            floatingActionButton: SizedBox(
              height: isLandscape ? 50 : 62,
              width: isLandscape ? 50 : 62,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: const Color(
                  0xFFFDBD03,
                ), // Warna kuning sesuai desain
                onPressed: () {
                  Get.toNamed(Routes.NOMINAL);
                },
                child: Icon(
                  Icons.add,
                  size: isLandscape ? 30 : 36,
                  color: Colors.white,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              color: const Color(0xFF1B8A4E), // Warna ungu utama sesuai desain
              child: Container(
                height: isLandscape ? 60 : 70,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(
                      Icons.home,
                      "Home",
                      0,
                      isLandscape: isLandscape,
                    ),
                    _buildNavItem(
                      Icons.history,
                      "Riwayat Transaksi",
                      1,
                      isLandscape: isLandscape,
                    ),
                    const SizedBox(width: 40), // Space for FAB
                    _buildNavItem(
                      Icons.history_toggle_off,
                      "Riwayat Hutang",
                      3,
                      isLandscape: isLandscape,
                    ),
                    _buildNavItem(
                      Icons.person,
                      "Profile",
                      4,
                      isLandscape: isLandscape,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Label "Top up" di bawah FAB
          Positioned(
            bottom: isLandscape ? 18 : 20,
            left: (screenWidth / 2) - 20,
            child: Text(
              "Top up",
              style: TextStyle(
                fontSize: isLandscape ? 10 : 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index, {
    bool isLandscape = false,
  }) {
    final isSelected = controller.selectedIndex.value == index;
    final color = isSelected ? Colors.white : Colors.white70;

    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: isLandscape ? 22 : 26),
            const SizedBox(height: 4),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: isLandscape ? 10 : 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
