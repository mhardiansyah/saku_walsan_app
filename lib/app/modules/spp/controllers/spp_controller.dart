import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/core/models/spp_models.dart';

class SppController extends GetxController {
  // === STEP WIZARD (foto 1–4) ===
  /// 1 = pilih jenis
  /// 2 = pilih tahun
  /// 3 = pilih bulan
  /// 4 = detail pembayaran
  var step = 1.obs;

  // === Pilihan Dummy (MODE A) ===
  final List<String> defaultJenis = const [
    'SPP',
    'Uang Masuk',
    'Eskul',
  ];

  final List<String> defaultTahun = const [
    'Tahun Ke-1',
    'Tahun Ke-2',
    'Tahun Ke-3',
  ];

  final List<String> defaultBulan = const [
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

  // === State dropdown ===
  var jenisList = <String>[].obs;
  var selectedJenis = ''.obs;

  var tahunList = <String>[].obs;
  var selectedTahun = ''.obs;

  var bulanList = <String>[].obs;
  var selectedBulan = ''.obs;

  // === State lama (month picker dialog) ===
  var selectedMonth = ''.obs; // masih dipakai dialog lama
  var availableSpp = <String>[].obs;

  // === Data dari API ===
  var isLoading = false.obs;
  var sppList = <Datum>[].obs;

  var paidCount = 0.obs;
  var unpaidCount = 0.obs;

  final box = GetStorage();
  var url = dotenv.env['base_url'];

  @override
  void onInit() {
    super.onInit();

    // --- MODE A: isi dummy ke observable list ---
    jenisList.assignAll(defaultJenis);
    tahunList.assignAll(defaultTahun);
    bulanList.assignAll(defaultBulan);

    // --- fetch data SPP untuk summary (paid / unpaid) ---
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

  // =====================================================
  // ===============  FUNGSI STEP WIZARD  ================
  // =====================================================

  void selectJenis(String value) {
    selectedJenis.value = value;
    // kalau ganti jenis, reset level bawah
    selectedTahun.value = '';
    selectedBulan.value = '';
    // opsional: reset step ke 1
    // step.value = 1;
  }

  void selectTahun(String value) {
    selectedTahun.value = value;
    // kalau ganti tahun, reset bulan
    selectedBulan.value = '';
  }

  void selectBulan(String value) {
    selectedBulan.value = value;
  }

  /// dipanggil dari tombol "Selanjutnya" / "Terapkan"
  void goToNextStep() {
    if (step.value == 1 && selectedJenis.value.isNotEmpty) {
      step.value = 2;
      return;
    }
    if (step.value == 2 && selectedTahun.value.isNotEmpty) {
      step.value = 3;
      return;
    }
    if (step.value == 3 && selectedBulan.value.isNotEmpty) {
      step.value = 4; // tampilkan detail pembayaran
      return;
    }
  }

  void resetSteps() {
    step.value = 1;
    selectedJenis.value = '';
    selectedTahun.value = '';
    selectedBulan.value = '';
  }

  // =====================================================
  // ==================  FETCH SPP API  ==================
  // =====================================================

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

        // Ambil hanya `List<Datum>` dari data.data
        final List<Datum> allItems = sppResponse.data.data;

        // Filter FULLDAY / BOARDING
        final filtered = allItems.where((d) {
          final tipe = d.student.tipeProgram.toUpperCase();
          return tipe == "FULLDAY" || tipe == "BOARDING";
        }).toList();

        sppList.assignAll(filtered);

        // Hitungan LUNAS
        paidCount.value = sppList.where((e) => e.status == "LUNAS").length;

        // Hitungan BELUM LUNAS
        final unpaidItems = sppList.where((e) => e.status == "BELUM_LUNAS");
        unpaidCount.value = unpaidItems.length;

        // Ambil bulan unik dari yang belum lunas
        final unpaidMonths = unpaidItems.map((e) => e.month).toSet().toList();
        availableSpp.assignAll(unpaidMonths);

        debugPrint('Available SPP: $availableSpp');
        debugPrint('Total Data: ${sppList.length}');
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

  Future<void> refreshData() async {
    final nisn = box.read('nisn') ?? '';
    if (nisn.isNotEmpty) {
      await fetchSpp(nisn);
    }
  }

  /// filter bulan berdasarkan STRING, bukan index
  List<Datum> get sppBySelectedMonth {
    if (selectedMonth.value.isEmpty) return sppList;
    return sppList.where((spp) => spp.month == selectedMonth.value).toList();
  }
}
