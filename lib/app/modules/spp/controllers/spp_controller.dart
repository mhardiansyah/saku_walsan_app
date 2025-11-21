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

  var monthList = <String>[].obs;
  var selectedMonth = ''.obs;

  var sppList = <SppPayment>[].obs; // hanya list SPP
  var otherList = <OltherPayment>[].obs; // list pembayaran lain

  var isLoading = false.obs;

  var paidCount = 0.obs;
  var unpaidCount = 0.obs;

  final box = GetStorage();
  var url = dotenv.env['base_url'];

  @override
  void onInit() {
    super.onInit();

    final nisn = box.read('nisn') ?? "";
    debugPrint("Loaded NISN: $nisn");

    if (nisn.isNotEmpty) {
      fetchSpp(nisn);
    } else {
      Get.snackbar(
        "Error",
        "NISN tidak ditemukan. Silakan login ulang.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> fetchSpp(String nisn) async {
    try {
      isLoading.value = true;

      final uri = Uri.parse("$url/santri/tagihan/$nisn");
      debugPrint("Requesting: $uri");

      final res = await http.get(
        uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      debugPrint("Code: ${res.statusCode}");
      debugPrint("Body: ${res.body}");

      if (res.statusCode != 200) {
        Get.snackbar(
          "Error",
          "Gagal memuat data (${res.statusCode})",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        return;
      }

      final decoded = jsonDecode(res.body);
      final Spp response = Spp.fromJson(decoded);

      final List<SppPayment> spp = response.data.data.sppPayment;
      sppList.assignAll(spp);

      final List<OltherPayment> other = response.data.data.oltherPayments;
      otherList.assignAll(other);

      final jenis = <String>[];
      if (spp.isNotEmpty) jenis.add("SPP");
      if (other.isNotEmpty) jenis.add("OTHER");
      jenisList.assignAll(jenis);

      debugPrint("Jenis Pembayaran: $jenis");

      final tahunAPI = spp.map((e) => e.year).toSet().toList()
        ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
      tahunList.assignAll(tahunAPI);
      debugPrint("Tahun: $tahunAPI");

      final urutanBulan = [
        "Januari",
        "Februari",
        "Maret",
        "April",
        "Mei",
        "Juni",
        "Juli",
        "Agustus",
        "September",
        "Oktober",
        "November",
        "Desember",
      ];

      final bulanAPI = spp.map((e) => e.month).toSet().toList()
        ..sort(
          (a, b) => urutanBulan.indexOf(a).compareTo(urutanBulan.indexOf(b)),
        );
      monthList.assignAll(bulanAPI);
      debugPrint("Bulan: $bulanAPI");

      paidCount.value = spp.where((e) => e.status != Status.BELUM_LUNAS).length;

      unpaidCount.value = spp
          .where((e) => e.status == Status.BELUM_LUNAS)
          .length;
    } catch (e) {
      debugPrint("Fetch Error: $e");

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

  String monthName(String input) {
    final bulanIndonesia = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    if (bulanIndonesia.contains(input)) {
      return input;
    }

    final m = int.tryParse(input) ?? 1;

    return DateFormat.MMMM('id_ID').format(DateTime(0, m));
  }

  List<SppPayment> get filteredSpp {
    return sppList.where((item) {
      final matchJenis =
          selectedJenis.value.isEmpty || selectedJenis.value == "SPP";

      final matchTahun =
          selectedTahun.value.isEmpty || selectedTahun.value == item.year;

      final matchMonth =
          selectedMonth.value.isEmpty || selectedMonth.value == item.month;

      return matchJenis && matchTahun && matchMonth;
    }).toList();
  }

  void goNext() {
    if (step.value == 1 && selectedJenis.value.isNotEmpty) {
      step.value = 2;
    } else if (step.value == 2 && selectedTahun.value.isNotEmpty) {
      step.value = 3;
    } else if (step.value == 3 && selectedMonth.value.isNotEmpty) {
      step.value = 4;
    }
  }

  void resetSelection() {
    step.value = 1;
    selectedJenis.value = "";
    selectedTahun.value = "";
    selectedMonth.value = "";
  }
}
