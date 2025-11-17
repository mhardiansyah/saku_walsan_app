import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/core/models/spp_models.dart';

class SppController extends GetxController {
  // === Observables ===
  var selectedMonth = ''.obs;
  var isLoading = false.obs;
  var sppList = <Spp>[].obs;
  var availableSpp = <String>[].obs;

  var paidCount = 0.obs;
  var unpaidCount = 0.obs;
  
  final box = GetStorage();

  final months = const [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  // === Lifecycle ===
  @override
  void onInit() {
    super.onInit();
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

  Future<void> fetchSpp(String nisn) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(
        'https://lap-uang-be.vercel.app/arrears/student/$nisn',
      );
      debugPrint('Fetching SPP from: $url');

      final res = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      debugPrint("Request URL: ${res.request?.url}");
      debugPrint("Response Code: ${res.statusCode}");
      debugPrint("Raw Response: ${res.body}");

      if (res.statusCode == 200) {
        final rawBody = res.body;

        final decoded = jsonDecode(rawBody);
        if (decoded is List) {
          final List<Spp> parsed = decoded.map((e) => Spp.fromJson(e)).toList();

          // sppList.assignAll(parsed);
          final filtered = parsed.where((e) {
            final tipe = e.student.tipeProgram?.toUpperCase() ?? "";
            return tipe == "FULLDAY" || tipe == "BOARDING";
          });
          sppList.assignAll(filtered);
        } else {
          debugPrint('Unexpected JSON format: not a list');
          sppList.clear();
        }

        paidCount.value = sppList.where((e) => e.status == "LUNAS").length;

        final unpaidFiltered = sppList.where((e) {
          final tipe = e.student.tipeProgram?.toUpperCase() ?? "";
          return e.status == "BELUM_LUNAS" &&
              (tipe == "FULLDAY" || tipe == "BOARDING");
        }).toList();

        unpaidCount.value = unpaidFiltered.length;

        final unpaidMonths =
            sppList
                .where((e) => e.status == "BELUM_LUNAS")
                .map((e) => e.month)
                .toSet()
                .toList()
              ..sort();

        availableSpp.assignAll(unpaidMonths.map((m) => months[m - 1]).toList());
        debugPrint('Available SPP: $availableSpp');
        debugPrint('panjang: ${availableSpp.length}');

        debugPrint('Total Data: ${sppList.length}');
        debugPrint(
          'Lunas: ${paidCount.value}, Belum Lunas: ${unpaidCount.value}',
        );
      } else {
        Get.snackbar(
          "Error",
          "Gagal memuat data (${res.statusCode})",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, st) {
      debugPrint("Error fetch SPP: $e");
      debugPrint("StackTrace: $st");
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

  // === Refresh Data Manual (optional) ===
  Future<void> refreshData() async {
    final nisn = box.read('nisn') ?? '';
    if (nisn.isNotEmpty) {
      await fetchSpp(nisn);
    }
  }

  List<Spp> get sppBySelectedMonth {
    if (selectedMonth.value.isEmpty) return sppList;
    final index = months.indexOf(selectedMonth.value) + 1;
    return sppList.where((spp) => spp.month == index).toList();
  }
}
