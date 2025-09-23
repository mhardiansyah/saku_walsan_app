// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailRiwayatView extends StatelessWidget {
  const DetailRiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    final transaksi = Get.arguments ?? {};

    final String nama = transaksi['nama'] ?? 'Santri';
    final String kelas = transaksi['kelas'] ?? '-';
    final String judul = transaksi['judul'] ?? '-';
    final int jumlah = transaksi['jumlah'] ?? 0;
    final DateTime? tanggal = transaksi['tanggal'];
    final String tipe = transaksi['tipe'] ?? '-';

    final String tanggalStr =
        tanggal != null ? DateFormat("dd MMM yyyy").format(tanggal) : '-';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Detail Transaksi",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color:  Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green[700],
                child: Text(
                  nama.isNotEmpty ? nama[0].toUpperCase() : "?",
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // box status hutang/lunas
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tipe == "hutang" ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tipe == "hutang" ? "Hutang" : "Lunas",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildRow("Nama:", nama),
              _buildRow("Kelas:", kelas),
              _buildRow("Judul:", judul),
              _buildRow("Tanggal Transaksi:", tanggalStr),
              _buildRow("Jumlah Bayar:", "Rp $jumlah"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(color: valueColor, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
