// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/spp_controller.dart';

class SppView extends GetView<SppController> {
  const SppView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SppController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'SPP',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Statistik SPP =====
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: "SPP Sudah terbayarkan",
                        count: controller.paidCount.value.toString(),
                        color: const Color(0xFF22C55E),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        title: "SPP Belum terbayarkan",
                        count: controller.unpaidCount.value.toString(),
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ===== Riwayat SPP =====
              const Text(
                "Riwayat SPP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              _buildHistoryItem(
                name: "Muhammad Dafleng",
                date: "20 Jan 2025",
                amount: "Rp2.500.000",
                imageUrl: "https://i.pravatar.cc/150?img=3",
              ),
              const SizedBox(height: 10),
              _buildHistoryItem(
                name: "Muhammad Dafleng",
                date: "20 Jan 2025",
                amount: "Rp2.500.000",
                imageUrl: "https://i.pravatar.cc/150?img=4",
              ),
              const SizedBox(height: 24),

              // ===== Pembayaran =====
              const Text(
                "Pembayaran",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              // ===== Dropdown Bulan =====
              Obx(
                () => GestureDetector(
                  onTap: () => _showMonthPickerDialog(context, controller),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectedMonth.value.isEmpty
                              ? "Silahkan Pilih Bulan Pembayaran"
                              : controller.selectedMonth.value,
                          style: TextStyle(
                            color: controller.selectedMonth.value.isEmpty
                                ? Colors.grey
                                : Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // ===== Tombol Bayar =====
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedMonth.value.isEmpty
                          ? Colors.grey
                          : const Color(0xFF1B8A4E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: controller.selectedMonth.value.isEmpty
                        ? null
                        : () {
                            Get.snackbar(
                              "Berhasil",
                              "Pembayaran bulan ${controller.selectedMonth.value} berhasil diproses",
                              backgroundColor: Colors.green.shade100,
                            );
                          },
                    child: const Text(
                      "Bayar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // === Statistik Card ===
  Widget _buildStatCard({
    required String title,
    required String count,
    required Color color,
  }) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }

  // === Riwayat Card ===
  Widget _buildHistoryItem({
    required String name,
    required String date,
    required String amount,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 25, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Lunas",
                  style: TextStyle(
                    color: Color(0xFF1B8A4E),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === Popup Pilihan Bulan (Setengah Layar) ===
  void _showMonthPickerDialog(BuildContext context, SppController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Pilih Bulan Pembayaran",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Obx(
                      () => Column(
                      children: controller.availableSpp.map((month) {
                        final isSelected =
                            controller.selectedMonth.value == month;
                        return RadioListTile<String>(
                          title: Text(month),
                          value: month,
                          groupValue: controller.selectedMonth.value,
                          activeColor: Colors.orange,
                          onChanged: (val) {
                            controller.selectedMonth.value = val!;
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B8A4E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Terapkan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
