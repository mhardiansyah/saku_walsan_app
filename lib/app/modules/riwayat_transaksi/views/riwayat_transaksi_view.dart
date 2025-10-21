import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/riwayat_transaksi_controller.dart';

class RiwayatTransaksiView extends GetView<RiwayatTransaksiController> {
  const RiwayatTransaksiView({super.key});

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
          'Riwayat Transaksi',
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
            ),
            const SizedBox(height: 16),

            /// --- Filter Buttons (Hari & Sesi) ---
            Row(
              children: [
                // --- Filter Hari ---
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () {
                        // buka dialog filter hari
                        Get.dialog(
                          Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
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
                                          groupValue:
                                              controller.tempSelectedHari.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedHari.value =
                                                val!;
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: const Text("Hari Ini"),
                                          value: "Hari ini",
                                          groupValue:
                                              controller.tempSelectedHari.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedHari.value =
                                                val!;
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: const Text("Perminggu"),
                                          value: "Minggu ini",
                                          groupValue:
                                              controller.tempSelectedHari.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedHari.value =
                                                val!;
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: const Text("Perbulan"),
                                          value: "Bulan ini",
                                          groupValue:
                                              controller.tempSelectedHari.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedHari.value =
                                                val!;
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: const Text("Pertahun"),
                                          value: "Tahun ini",
                                          groupValue:
                                              controller.tempSelectedHari.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedHari.value =
                                                val!;
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
                                        backgroundColor: const Color(
                                          0xFF1B8A4E,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.selectedHari.value =
                                            controller.tempSelectedHari.value;
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
                        );
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
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // --- Filter Sesi ---
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () {
                        // buka dialog filter sesi
                        Get.dialog(
                          Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
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
                                          groupValue:
                                              controller.tempSelectedSesi.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedSesi.value =
                                                val!;
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: const Text("Pagi"),
                                          value: "Pagi",
                                          groupValue:
                                              controller.tempSelectedSesi.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedSesi.value =
                                                val!;
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: const Text("Siang"),
                                          value: "Siang",
                                          groupValue:
                                              controller.tempSelectedSesi.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedSesi.value =
                                                val!;
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: const Text("Sore"),
                                          value: "Sore",
                                          groupValue:
                                              controller.tempSelectedSesi.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedSesi.value =
                                                val!;
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: const Text("Malam"),
                                          value: "Malam",
                                          groupValue:
                                              controller.tempSelectedSesi.value,
                                          activeColor: Colors.orange,
                                          onChanged: (val) {
                                            controller.tempSelectedSesi.value =
                                                val!;
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
                                        backgroundColor: const Color(
                                          0xFF1B8A4E,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.selectedSesi.value =
                                            controller.tempSelectedSesi.value;
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
                        );
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
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredTransaksi.length,
                  itemBuilder: (context, index) {
                    final transaksi = controller.filteredTransaksi[index];
                    final String nama = transaksi.santri.name ?? 'Santri';
                    final String kelas = transaksi.santri.kelas ?? '-';
                    final int jumlah = transaksi.totalAmount ?? 0;
                    final DateTime tanggal = transaksi.createdAt as DateTime;
                    final String tanggalStr = DateFormat(
                      'dd MMM yyyy',
                    ).format(tanggal);
                    final String tipe = transaksi.status ?? '';

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
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              color: Color.fromRGBO(158, 158, 158, 1),
                            ),
                          ),
                          const SizedBox(width: 12),
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
                              ],
                            ),
                          ),
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
                                formatRupiah(jumlah),
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
                                  color: tipe == "hutang"
                                      ? Colors.red[100]
                                      : Colors.green[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  tipe == "hutang" ? "Hutang" : "Lunas",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: tipe == "hutang"
                                        ? Colors.red
                                        : Colors.green[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatRupiah(int amount) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }
}
