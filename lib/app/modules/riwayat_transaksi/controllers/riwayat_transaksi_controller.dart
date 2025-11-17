import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/core/models/history_models.dart';
import 'package:saku_walsan_app/app/core/models/items_models.dart';

class RiwayatTransaksiController extends GetxController {
  var url = dotenv.env['base_url'];
  var allHistoryList = <HistoryDetail>[].obs;
  var allItems = <Items>[];
  var isLoading = false.obs;

  // Filter aktif (dipakai buat filteredTransaksi)
  var selectedHari = "Semua".obs;
  var selectedSesi = "Semua".obs;

  // Filter sementara (dipakai di dialog)
  var tempSelectedHari = "Semua".obs;
  var tempSelectedSesi = "Semua".obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
    final santriId = box.read('santriId') as int?;
    if (santriId != null) {
      fetchRiwayatTransaksi(santriId);
    }
  }

  Future<void> fetchProduct() async {
    try {
      final urlItems = Uri.parse("$url/items");
      final response = await http.get(urlItems);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonresponse = json.decode(response.body);
        final List<dynamic> data = jsonresponse['data'];
        // print("Products data: $data");
        allItems = data.map((item) => Items.fromJson(item)).toList();
      } else {
        Get.snackbar('Error', 'Gagal ambil data produk');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed fetch: $e', backgroundColor: Colors.red);
    }
  }

  void fetchRiwayatTransaksi(int santriId) async {
    try {
      isLoading.value = true;
      var urlRiwayatTransaksi = Uri.parse("$url/history/santri/$santriId");
      final response = await http.get(urlRiwayatTransaksi);
      if (response.statusCode == 200) {
        final data = historyFromJson(response.body);
        allHistoryList.value = data.historyDetail;
      } else {
        Get.snackbar('Error', 'Failed to fetch transaction history');
      }
    } catch (e) {
      print("Error fetching transaction history: $e");
    } finally {
      isLoading.value = false;
    }
  }

  int get totalTransaksiBulanIni {
    final now = DateTime.now();
    return allHistoryList
        .where(
          (t) => t.createdAt.month == now.month && t.createdAt.year == now.year,
        )
        .length;
  }

  int get totalHutangBulanIni {
    final now = DateTime.now();
    final kasbonBulanIni = allHistoryList
        .where(
          (t) =>
              t.createdAt.month == now.month &&
              t.createdAt.year == now.year &&
              t.status.toLowerCase() == 'Hutang',
        )
        .fold<int>(0, (sum, t) => sum + t.totalAmount);
    return kasbonBulanIni;
  }

  int get totalHutangBulanLalu {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1);
    final kasbonBulanLalu = allHistoryList
        .where(
          (t) =>
              t.createdAt.month == lastMonth.month &&
              t.createdAt.year == lastMonth.year &&
              t.status.toLowerCase() == 'Hutang',
        )
        .fold<int>(0, (sum, t) => sum + t.totalAmount);
    return kasbonBulanLalu;
  }

  double get persentaseKasbon {
    final bulanLalu = totalHutangBulanLalu;
    final bulanIni = totalHutangBulanIni;
    if (bulanLalu == 0 && bulanIni == 0) return 0;
    if (bulanLalu == 0) return 100;
    return ((bulanIni - bulanLalu) / bulanLalu) * 100;
  }

  List<HistoryDetail> get filteredTransaksi {
    final now = DateTime.now();
    var list = allHistoryList.toList();

    // Filter Hari
    list = list.where((t) {
      final d = t.createdAt;
      switch (selectedHari.value) {
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
        default: // Semua
          return true;
      }
    }).toList();

    // Filter Sesi
    list = list.where((t) {
      final h = t.createdAt.hour;
      switch (selectedSesi.value) {
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
}
