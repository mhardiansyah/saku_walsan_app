import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pembayaran_controller.dart';

class PembayaranView extends GetView<PembayaranController> {
  const PembayaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Pembayaran",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: Obx(() {
        return Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              "silahkan lakukan transaksi nya",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 20),

            // ====================== CARD ======================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA), // sesuai desain
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// LOGO BANK (per channel berbeda)
                  SizedBox(
                    height: controller.channel.value == "MUAMALAT" ? 50 : 55,
                    child: Image.asset(
                      controller.getLogoByChannel(),
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Berikut Nomor VA :",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    controller.vaNumber.value,
                    style: const TextStyle(
                      fontSize: 22, // sesuai desain
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "*Kode ini berlaku sampai ${controller.expired.value}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ================= BUTTON ========================
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () => controller.refreshData(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  minimumSize: const Size(240, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Refresh Halaman",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
