// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/modules/riwayat_transaksi/controllers/riwayat_transaksi_controller.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';
import '../controllers/nominal_controller.dart';

class NominalView extends StatelessWidget {
  NominalView({super.key});
  final NominalController controller = Get.put(NominalController());
  final RiwayatTransaksiController riwayatController = Get.put(
    RiwayatTransaksiController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Top Up',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Pilih nominal",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            /// Input nominal
            SizedBox(
              width: 400,
              child: Obx(() {
                return TextField(
                  key: ValueKey(controller.inputText.value),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: controller.updateNominalFromText,
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Masukkan nominal",
                    hintStyle: const TextStyle(color: Colors.black87),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black87),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black87),
                    ),
                  ),
                  controller:
                      TextEditingController(text: controller.inputText.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                            offset: controller.inputText.value.length,
                          ),
                        ),
                );
              }),
            ),

            const SizedBox(height: 32),

            /// Jumlah cepat
            const Text(
              "Jumlah cepat*",
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Obx(() {
              final selectedNominal = controller.selectedNominal.value;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.quickAmounts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.0,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final amount = controller.quickAmounts[index];
                  final isSelected = selectedNominal == amount;

                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isSelected
                          ? const Color(0xFF1B8A4E)
                          : Colors.transparent,
                      side: const BorderSide(color: Colors.black87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => controller.pilihNominal(amount),
                    child: Text(
                      '${amount ~/ 1000}ribu',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  );
                },
              );
            }),

            const SizedBox(height: 32),

            /// History Transaksi Top Up
            const Text(
              "Riwayat Top Up",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
  final topupList = riwayatController.transaksiList
      .where((t) => t['tipe'] == "topup")
      .toList();

  if (topupList.isEmpty) {
    return const Text(
      "Belum ada riwayat top up",
      style: TextStyle(color: Colors.grey),
    );
  }

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: topupList.length,
    itemBuilder: (context, index) {
      final transaksi = topupList[index];
      final String nama = transaksi['nama'] ?? 'Santri';
      final String kelas = transaksi['kelas'] ?? '-';
      final int jumlah = transaksi['jumlah'] ?? 0;
      final DateTime tanggal = transaksi['tanggal'] as DateTime;
      final String tanggalStr = DateFormat('dd MMM yyyy').format(tanggal);

      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.toNamed(Routes.DETAIL_RIWAYAT, arguments: transaksi);
        },
        child: Container(
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
              // Avatar (placeholder)
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.black54),
              ),
              const SizedBox(width: 12),

              // Nama & kelas
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      kelas,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Tanggal & jumlah (badge)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tanggalStr,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(jumlah),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}),



            const SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B8A4E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () async {
              await controller.topUpSaldo();
            },
            child: const Text(
              "Top Up",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
