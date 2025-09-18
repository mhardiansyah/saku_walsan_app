// ignore_for_file: invalid_use_of_protected_member
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatTransaksiController extends GetxController {
  var transaksiList = <Map<String, dynamic>>[
    {
      "nama": "Santri A",
      "kelas": "XI RPL 1",
      "judul": "Jajan di Kantin",
      "tanggal": DateTime(2025, 9, 16, 8, 30),
      "jumlah": 15000,
      "tipe": "jajan",
    },
    {
      "nama": "Santri B",
      "kelas": "XI RPL 2",
      "judul": "Topup Bulanan",
      "tanggal": DateTime(2025, 9, 10, 14, 15),
      "jumlah": 200000,
      "tipe": "topup",
    },
    {
      "nama": "Santri C",
      "kelas": "XI TKJ 1",
      "judul": "Hutang Kantin",
      "tanggal": DateTime(2025, 9, 9, 19, 0),
      "jumlah": 5000,
      "tipe": "hutang",
    },
  ].obs;

  var selectedHari = "Hari ini".obs;
  var selectedSesi = "Semua".obs;

  List<Map<String, dynamic>> get filteredTransaksi {
    final now = DateTime.now();
    List<Map<String, dynamic>> list = transaksiList;

    // Filter hari
    list = list.where((t) {
      final d = t["tanggal"] as DateTime;
      switch (selectedHari.value) {
        case "Semua":
          return true;
        case "Hari ini":
          return DateFormat('yyyy-MM-dd').format(d) ==
              DateFormat('yyyy-MM-dd').format(now);
        case "Minggu ini":
          final start = now.subtract(Duration(days: now.weekday - 1));
          final end = start.add(const Duration(days: 6));
          return d.isAfter(start.subtract(const Duration(days: 1))) &&
              d.isBefore(end.add(const Duration(days: 1)));
        case "Bulan ini":
          return d.month == now.month && d.year == now.year;
        case "Tahun ini":
          return d.year == now.year;
        default:
          return true;
      }
    }).toList();

    // Filter sesi
    list = list.where((t) {
      final h = (t["tanggal"] as DateTime).hour;
      switch (selectedSesi.value) {
        case "Semua":
          return true;
        case "Pagi":
          return h >= 5 && h < 12;
        case "Siang":
          return h >= 12 && h < 15;
        case "Sore":
          return h >= 15 && h < 18;
        case "Malam":
          return h >= 18 || h < 5;
        default: // Semua
          return true;
      }
    }).toList();

    return list;
  }

  get searchQuery => null;

  void resetFilter() {
    selectedHari.value = "Hari ini";
    selectedSesi.value = "Semua";
  }
}
