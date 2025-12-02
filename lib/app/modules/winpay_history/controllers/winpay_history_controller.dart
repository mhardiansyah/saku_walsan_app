import 'package:get/get.dart';

class WinpayHistoryController extends GetxController {
  final RxList<Map<String, dynamic>> transaksiList = <Map<String, dynamic>>[
    {
      "nama": "Muhammad Dafleng",
      "foto":
          "https://i.pravatar.cc/150?img=3",
      "tanggal": DateTime(2025, 1, 20),
      "total": 2500000,
      "jenis": "SPP",
      "status": "Lunas",
    }
  ].obs;

  RxList<Map<String, dynamic>> filteredList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    filteredList.assignAll(transaksiList);
    super.onInit();
  }

  void searchSantri(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(transaksiList);
    } else {
      filteredList.assignAll(
        transaksiList.where(
          (item) => item["nama"].toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}
