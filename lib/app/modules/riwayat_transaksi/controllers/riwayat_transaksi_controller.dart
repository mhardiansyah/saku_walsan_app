import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/core/models/history_models.dart';

class RiwayatTransaksiController extends GetxController {
  var url = dotenv.env['base_url'];
  var allHistoryList = <HistoryDetail>[].obs;
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
    final santriId = box.read('santriId') as int?;
    if (santriId != null) {
      fetchRiwayatTransaksi(santriId);
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
      print("❌ Error fetching transaction history: $e");
    } finally {
      isLoading.value = false;
    }
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
