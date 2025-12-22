import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/core/models/spp_models.dart';

class SppController extends GetxController {
  /// STEP
  /// 1 = pilih jenis
  /// 2 = pilih detail (bulan / other)
  /// 3 = ringkasan
  var step = 1.obs;

  /// JENIS
  var jenisList = <String>[].obs;
  var selectedJenis = ''.obs; // SPP | OTHER

  /// SPP
  var sppList = <SppPayment>[].obs;
  var selectedMonths = <String>[].obs; // Januari|2025
  var selectedSpp = <SppPayment>[].obs;
  var tempSelectedMonths = <String>[].obs;

  //pembayaran
  var paidCount = 0.obs;
  var unpaidCount = 0.obs;
  final cicilanControllers = <String, TextEditingController>{};

  var totalAdmin = 5000.obs;

  /// OTHER
  var otherList = <OltherPayment>[].obs;
  var selectedOtherPayment = Rxn<OltherPayment>();
  var tempSelectedOther = Rxn<OltherPayment>();

  /// TOTAL
  var totalNominal = 0.obs;
  var adminFee = 5000;
  var totalPembayaran = 0.obs;

  /// STATE
  var isLoading = false.obs;

  final box = GetStorage();
  final url = dotenv.env['base_url'];

  @override
  void onInit() {
    super.onInit();
    final nisn = box.read('nisn');
    if (nisn != null) fetchSpp(nisn);
  }

  /// ================= FETCH =================
  Future<void> fetchSpp(String nisn) async {
    try {
      isLoading.value = true;
      final res = await http.get(Uri.parse("$url/santri/tagihan/$nisn"));
      print("res: $res");

      if (res.statusCode != 200) return;

      final decoded = jsonDecode(res.body);
      final response = Spp.fromJson(decoded);
      print("response : $response");
      print("response data : ${response.data.data.sppPayment}");
      print("response other data : ${response.data.data.oltherPayments}");

      sppList.assignAll(response.data.data.sppPayment);
      otherList.assignAll(response.data.data.oltherPayments);

      final jenis = <String>[];
      if (sppList.isNotEmpty) jenis.add("SPP");
      if (otherList.isNotEmpty) jenis.add("OTHER");
      jenisList.assignAll(jenis);
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= STEP 1 =================
  void selectJenis(String jenis) {
    selectedJenis.value = jenis;

    // reset
    selectedMonths.clear();
    selectedOtherPayment.value = null;
    selectedSpp.clear();
    totalNominal.value = 0;
    totalPembayaran.value = 0;

    step.value = 2;
  }

  /// ================= SPP =================
  void toggleMonth(String monthYear) {
    if (selectedMonths.contains(monthYear)) {
      selectedMonths.remove(monthYear);
    } else {
      selectedMonths.add(monthYear);
    }
  }

  void buildSppSummary() {
    selectedSpp.clear();

    for (final my in selectedMonths) {
      final split = my.split('|');
      final month = split[0];
      final year = split[1];

      selectedSpp.addAll(
        sppList.where((e) => e.month == month && e.year == year),
      );
    }

    totalNominal.value = selectedSpp.fold(0, (sum, e) => sum + e.nominal);
    totalPembayaran.value = totalNominal.value + adminFee;

    step.value = 3;
  }

  /// ================= OTHER =================
  void selectOther(OltherPayment other) {
    selectedOtherPayment.value = other;

    totalNominal.value = other.amount;
    totalPembayaran.value = totalNominal.value + adminFee;

    step.value = 3;
  }

  /// ================= PAYMENT ITEMS =================
  List<Map<String, dynamic>> get paymentItems {
    if (selectedJenis.value == "SPP") {
      return selectedSpp
          .map(
            (e) => {
              "type": "SPP",
              "id": e.id,
              "month": e.month,
              "year": e.year,
              "nominal": e.nominal,
            },
          )
          .toList();
    }

    if (selectedJenis.value == "OTHER" && selectedOtherPayment.value != null) {
      final o = selectedOtherPayment.value!;
      return [
        {"type": "OTHER", "id": o.id, "name": o.type.name, "nominal": o.amount},
      ];
    }

    return [];
  }

  List<String> get monthList {
    return sppList.map((e) => "${e.month}|${e.year}").toSet().toList();
  }

  String monthName(String month) {
    const bulan = {
      "Januari": "Januari",
      "Februari": "Februari",
      "Maret": "Maret",
      "April": "April",
      "Mei": "Mei",
      "Juni": "Juni",
      "Juli": "Juli",
      "Agustus": "Agustus",
      "September": "September",
      "Oktober": "Oktober",
      "November": "November",
      "Desember": "Desember",
    };

    return bulan[month] ?? month;
  }

  int monthToNumber(String month) {
    const bulan = {
      "Januari": 1,
      "Februari": 2,
      "Maret": 3,
      "April": 4,
      "Mei": 5,
      "Juni": 6,
      "Juli": 7,
      "Agustus": 8,
      "September": 9,
      "Oktober": 10,
      "November": 11,
      "Desember": 12,
    };

    return bulan[month] ?? 1;
  }

  bool isSequentialAndNoSkip(List<String> list) {
    if (list.isEmpty) return true;

    final parsed = list.map((e) {
      final s = e.split('|');
      return DateTime(int.parse(s[1]), monthToNumber(s[0]));
    }).toList()..sort();

    for (int i = 1; i < parsed.length; i++) {
      final prev = parsed[i - 1];
      final curr = parsed[i];
      if (curr.difference(prev).inDays > 31) return false;
    }
    return true;
  }

  void resetAll() {
    step.value = 1;
    selectedJenis.value = '';
    selectedMonths.clear();
    selectedOtherPayment.value = null;
    selectedSpp.clear();
    totalNominal.value = 0;
    totalPembayaran.value = 0;
  }
}
