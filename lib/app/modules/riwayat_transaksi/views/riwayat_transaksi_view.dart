// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saku_walsan_app/app/modules/home/views/home_view.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';
import '../controllers/riwayat_transaksi_controller.dart';

class RiwayatTransaksiView extends GetView<RiwayatTransaksiController> {
  const RiwayatTransaksiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1B8A4E),
        elevation: 0,
      ),
      body: Column(
        children: [
          /// --- FILTER TANGGAL ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        controller.filterByDate(picked);
                      }
                    },
                    icon: const Icon(Icons.date_range),
                    label: Obx(() => Text(
                          controller.selectedDate.value != null
                              ? "${controller.selectedDate.value!.day}-${controller.selectedDate.value!.month}-${controller.selectedDate.value!.year}"
                              : "Pilih Tanggal",
                        )),
                  ),
                ),
              ],
            ),
          ),

          /// --- LIST TRANSAKSI ---
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredTransaksi.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1),
                itemBuilder: (context, index) {
                  final transaksi = controller.filteredTransaksi[index];
                  final isJajan = transaksi['tipe'] == "jajan";
                  final isTopup = transaksi['tipe'] == "topup";
                  final isHutang = transaksi['tipe'] == "hutang";

                  Color color = Colors.blue;
                  IconData icon = Icons.payment;

                  if (isJajan) {
                    color = Colors.orange;
                    icon = Icons.fastfood_rounded;
                  } else if (isTopup) {
                    color = Colors.green;
                    icon = Icons.trending_up_rounded;
                  } else if (isHutang) {
                    color = Colors.red;
                    icon = Icons.warning_amber_rounded;
                  }

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withOpacity(0.2),
                      child: Icon(icon, color: color),
                    ),
                    title: Text(transaksi['judul']),
                    subtitle: Text(transaksi['tanggal']),
                    trailing: Text(
                      "${isTopup ? '+' : '-'} Rp ${transaksi['jumlah']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isTopup ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
