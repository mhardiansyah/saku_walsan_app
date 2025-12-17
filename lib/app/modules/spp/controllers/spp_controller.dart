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
  var selectedMonths = <String>[].obs;
  var selectedOther = Rxn<OltherPayment>();
  var tempSelectedOther = Rxn<OltherPayment>();
  var selectedOtherPayment = Rxn<OltherPayment>();

  var selectedSpp = <SppPayment>[].obs;

  var totalNominal = 0.obs;
  var totalAdmin = 5000.obs;
  var totalPembayaran = 0.obs;
  var tempSelectedMonths = <String>[].obs;

  var sppList = <SppPayment>[].obs;
  var otherList = <OltherPayment>[].obs;

  var cicilanControllers = <String, TextEditingController>{}.obs;

  var isLoading = false.obs;

  var paidCount = 0.obs;
  var unpaidCount = 0.obs;

  final box = GetStorage();
  var url = dotenv.env['base_url'];

  @override
  void onInit() {
    super.onInit();

    final nisn = box.read('nisn') ?? "";
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

  bool isSequentialAndNoSkip(List<String> selected) {
    if (selected.isEmpty) return true;

    const bulanOrder = [
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

    // convert "Bulan|Tahun" → map yang TYPED
    final parsed = selected.map((e) {
      final split = e.split('|');
      return {'bulan': split[0] as String, 'tahun': int.parse(split[1])};
    }).toList();

    // sort by tahun → bulan
    parsed.sort((a, b) {
      final yearCompare = (a['tahun'] as int).compareTo(b['tahun'] as int);
      if (yearCompare != 0) return yearCompare;

      return bulanOrder
          .indexOf(a['bulan'] as String)
          .compareTo(bulanOrder.indexOf(b['bulan'] as String));
    });

    // validasi berurutan
    for (int i = 1; i < parsed.length; i++) {
      final prev = parsed[i - 1];
      final curr = parsed[i];

      final prevMonthIdx = bulanOrder.indexOf(prev['bulan'] as String);
      final currMonthIdx = bulanOrder.indexOf(curr['bulan'] as String);

      final prevYear = prev['tahun'] as int;
      final currYear = curr['tahun'] as int;

      final valid =
          // tahun sama → bulan harus lanjut
          (currYear == prevYear && currMonthIdx == prevMonthIdx + 1) ||
          // desember → januari tahun depan
          (currYear == prevYear + 1 && prevMonthIdx == 11 && currMonthIdx == 0);

      if (!valid) return false;
    }

    return true;
  }

  Future<void> fetchSpp(String nisn) async {
    try {
      isLoading.value = true;

      final uri = Uri.parse("$url/santri/tagihan/$nisn");
      print(" Requesting API: $uri");

      final res = await http.get(uri);

      print(" Status Code: ${res.statusCode}");
      print(" Response Body: ${res.body}");

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

      final spp = response.data.data.sppPayment;
      sppList.assignAll(spp);

      final other = response.data.data.oltherPayments;
      otherList.assignAll(other);

      print(" Jumlah SPP dari API: ${spp.length}");

      final jenis = <String>[];
      if (spp.isNotEmpty) jenis.add("SPP");
      if (other.isNotEmpty) jenis.add("OTHER");
      jenisList.assignAll(jenis);

      final tahunAPI = spp.map((e) => e.year).toSet().toList()
        ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
      tahunList.assignAll(tahunAPI);

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

      final monthYearList = spp
          .map((e) => "${e.month}|${e.year}")
          .toSet()
          .toList();

      monthYearList.sort((a, b) {
        final aSplit = a.split('|');
        final bSplit = b.split('|');

        final yearCompare = int.parse(
          aSplit[1],
        ).compareTo(int.parse(bSplit[1]));
        if (yearCompare != 0) return yearCompare;

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

        return urutanBulan
            .indexOf(aSplit[0])
            .compareTo(urutanBulan.indexOf(bSplit[0]));
      });

      monthList.assignAll(monthYearList);
    } catch (e) {
      print(" ERROR fetchSpp: $e");

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

  void selectYear(String tahun) {
    selectedTahun.value = tahun;

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

    final bulan =
        sppList
            .where((e) => e.year == tahun)
            .map((e) => e.month)
            .toSet()
            .toList()
          ..sort(
            (a, b) => urutanBulan.indexOf(a).compareTo(urutanBulan.indexOf(b)),
          );

    monthList.assignAll(bulan);
  }

  void summarySelectedSpp() {
    selectedSpp.clear();

    if (selectedMonths.isEmpty) {
      totalNominal.value = 0;
      totalPembayaran.value = totalAdmin.value;
      return;
    }

    for (final my in selectedMonths) {
      final parts = my.split('|');
      final month = parts[0];
      final year = parts.length > 1 ? parts[1] : selectedTahun.value;

      selectedSpp.addAll(
        sppList.where((e) => e.month == month && e.year == year),
      );
    }

    // Optional: buat display
    selectedTahun.value = selectedMonths.first.split('|')[1];

    totalNominal.value = selectedSpp.fold(0, (sum, item) => sum + item.nominal);
    totalPembayaran.value = totalNominal.value + totalAdmin.value;
  }

  void summarySelectedOther() {
    if (selectedOtherPayment.value == null) {
      totalNominal.value = 0;
      totalPembayaran.value = totalAdmin.value;
      return;
    }

    totalNominal.value = selectedOtherPayment.value!.amount;
    totalPembayaran.value = totalNominal.value + totalAdmin.value;
  }

  String monthName(String input) {
    final bulanID = [
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

    if (bulanID.contains(input)) return input;

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
          selectedMonths.isEmpty || selectedMonths.contains(item.month);

      return matchJenis && matchTahun && matchMonth;
    }).toList();
  }

  void goNext() {
    if (step.value == 1 && selectedJenis.value.isNotEmpty) {
      // Jika SPP -> langsung loncat ke pilih bulan (step 3)
      if (selectedJenis.value == "SPP") {
        step.value = 3;
        return;
      }

      // Jika OTHER -> langsung ke step 4 (tampilkan pilihan pembayaran OTHER)
      if (selectedJenis.value == "OTHER") {
        step.value = 4;
        return;
      }

      step.value = 2;
    } else if (step.value == 2 && selectedTahun.value.isNotEmpty) {
      step.value = 3;
    } else if (step.value == 3 && selectedMonths.isNotEmpty) {
      step.value = 4;
    }
  }

  String getYearForMonth(String month) {
    try {
      return sppList.firstWhere((e) => e.month == month).year;
    } catch (_) {
      return "-";
    }
  }

  void resetSelection() {
    step.value = 1;
    selectedJenis.value = "";
    selectedTahun.value = "";
    selectedMonths.clear();
    cicilanControllers.clear();
  }
}
