import 'package:get/get.dart';

class RiwayatTransaksiController extends GetxController {
  /// Data dummy transaksi (nanti diganti dari API/backend)
  var transaksi = [
    {
      "judul": "Jajan di Kantin",
      "tanggal": "11 Sept 2025",
      "jumlah": 15000,
      "tipe": "jajan",
    },
    {
      "judul": "Topup Bulanan",
      "tanggal": "10 Sept 2025",
      "jumlah": 200000,
      "tipe": "topup",
    },
    {
      "judul": "Bayar Hutang Kantin",
      "tanggal": "9 Sept 2025",
      "jumlah": 5000,
      "tipe": "hutang",
    },
  ].obs;

  var selectedDate = Rxn<DateTime>();

  /// List transaksi terfilter
  List<Map<String, dynamic>> get filteredTransaksi {
    if (selectedDate.value == null) {
      return transaksi;
    }
    return transaksi.where((t) {
      return t['tanggal'] == "11 Sept 2025"; // contoh filter
    }).toList();
  }

  void filterByDate(DateTime date) {
    selectedDate.value = date;
  }
}
