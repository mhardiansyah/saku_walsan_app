import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/core/models/spp_models.dart';

class SppController extends GetxController {
  var step = 1.obs;

  var jenisList = <String>[].obs;
  var selectedJenis = ''.obs;

  var tahunList = <String>[].obs;
  var selectedTahun = ''.obs;

  var selectedMonth = ''.obs;
  var availableSpp = <String>[].obs;

  var isLoading = false.obs;
  var sppList = <Datum>[].obs;

  var paidCount = 0.obs;
  var unpaidCount = 0.obs;

  final box = GetStorage();
  var url = dotenv.env['base_url'];

  @override
  void onInit() {
    super.onInit();

    tahunList.assignAll(['Tahun Ke-1', 'Tahun Ke-2', 'Tahun Ke-3']);

    final nisn = box.read('nisn') ?? '';
    debugPrint('NISN loaded: $nisn');

    if (nisn.isNotEmpty) {
      fetchSpp(nisn);
    } else {
      Get.snackbar(
        'Error',
        'NISN tidak ditemukan. Silakan login ulang.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Extract month name
  String extractMonth(DateTime date) {
    return DateFormat('MMMM', 'id_ID').format(date);
  }

  Future<void> fetchSpp(String nisn) async {
    try {
      isLoading.value = true;

      final urlSpp = Uri.parse('$url/santri/tagihan/$nisn');
      debugPrint('Fetching SPP from: $urlSpp');

      final res = await http.get(
        urlSpp,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      debugPrint("Response Code: ${res.statusCode}");
      debugPrint("Raw Response: ${res.body}");

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        final Spp sppResponse = Spp.fromJson(decoded);

        final List<Datum> allItems = sppResponse.data.data;

        // Assign list
        sppList.assignAll(allItems);

        final kategoriList = allItems.map((e) => e.kategori).toSet().toList();
        debugPrint('Kategori ditemukan: $kategoriList');
        jenisList.assignAll(kategoriList);

        final tahunListAPI = allItems
            .map((e) => e.tanggalDibuat.year.toString())
            .toSet()
            .toList();
        tahunList.assignAll(tahunListAPI);
        debugPrint("Tahun dari API: $tahunListAPI");

        // Count paid/unpaid
        paidCount.value = sppList.where((e) => e.status == "LUNAS").length;
        final unpaidItems = sppList.where((e) => e.status == "BELUM_LUNAS");
        unpaidCount.value = unpaidItems.length;

        // Collect unique months
        final unpaidMonths = unpaidItems
            .map((e) => extractMonth(e.tanggalDibuat))
            .toSet()
            .toList();

        availableSpp.assignAll(unpaidMonths);

        debugPrint('Available SPP: $availableSpp');
      } else {
        Get.snackbar(
          "Error",
          "Gagal memuat data (${res.statusCode})",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error fetch SPP: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Filter berdasarkan bulan (dari tanggalDibuat)
  List<Datum> get sppBySelectedMonth {
    if (selectedMonth.value.isEmpty) return sppList;
    return sppList
        .where((spp) => extractMonth(spp.tanggalDibuat) == selectedMonth.value)
        .toList();
  }
}
