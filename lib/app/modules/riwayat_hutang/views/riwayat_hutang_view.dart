import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/modules/riwayat_transaksi/controllers/riwayat_transaksi_controller.dart';

class RiwayatHutangView extends GetView<RiwayatTransaksiController> {
  const RiwayatHutangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Riwayat Hutang',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// --- Search Field ---
            TextField(
              decoration: InputDecoration(
                hintText: "Masukan nama Santri",
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (val) {
                controller.searchQuery.value = val;
              },
            ),
            const SizedBox(height: 16),

            /// --- Filter Buttons (Hari & Sesi) ---
            Row(
              children: [
                /// Filter Hari
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () {
                        _showHariDialog();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B8A4E),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.selectedHari.value,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// Filter Sesi
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () {
                        _showSesiDialog();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B8A4E),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.selectedSesi.value,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// --- List Riwayat Hutang ---
            Expanded(
              child: Obx(
                () {
                  final hutangList = controller.filteredTransaksi
                      .where((t) => t['tipe'] == 'hutang')
                      .toList();

                  if (hutangList.isEmpty) {
                    return const Center(
                      child: Text(
                        "Belum ada hutang",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: hutangList.length,
                    itemBuilder: (context, index) {
                      final transaksi = hutangList[index];

                      final String nama = transaksi['nama'] ?? 'Santri';
                      final String kelas = transaksi['kelas'] ?? '-';
                      final String judul = transaksi['judul'] ?? '';
                      final int jumlah = transaksi['jumlah'] ?? 0;
                      final DateTime tanggal =
                          transaksi['tanggal'] as DateTime;
                      final String tanggalStr =
                          DateFormat('dd MMM yyyy').format(tanggal);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.grey[200],
                              child: const Icon(Icons.person,
                                  color: Colors.grey),
                            ),
                            const SizedBox(width: 12),

                            // Nama, kelas & judul
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nama,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    kelas,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    judul,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),

                            // Jumlah + tanggal
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  tanggalStr,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rp ${jumlah.toString()}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "Hutang",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHariDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text("Hari Ini"),
                      value: "Hari ini",
                      groupValue: controller.selectedHari.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedHari.value = val!;
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Perminggu"),
                      value: "Minggu ini",
                      groupValue: controller.selectedHari.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedHari.value = val!;
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Perbulan"),
                      value: "Bulan ini",
                      groupValue: controller.selectedHari.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedHari.value = val!;
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Pertahun"),
                      value: "Tahun ini",
                      groupValue: controller.selectedHari.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedHari.value = val!;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
                  onPressed: () => Get.back(),
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
    );
  }

  void _showSesiDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text("Semua"),
                      value: "Semua",
                      groupValue: controller.selectedSesi.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedSesi.value = val!;
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Pagi"),
                      value: "Pagi",
                      groupValue: controller.selectedSesi.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedSesi.value = val!;
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Siang"),
                      value: "Siang",
                      groupValue: controller.selectedSesi.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedSesi.value = val!;
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Sore"),
                      value: "Sore",
                      groupValue: controller.selectedSesi.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedSesi.value = val!;
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Malam"),
                      value: "Malam",
                      groupValue: controller.selectedSesi.value,
                      activeColor: Colors.orange,
                      onChanged: (val) {
                        controller.selectedSesi.value = val!;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
                  onPressed: () => Get.back(),
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
    );
  }
}
