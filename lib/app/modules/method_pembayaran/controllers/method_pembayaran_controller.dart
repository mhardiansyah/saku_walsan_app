import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MethodPembayaranController extends GetxController {
  var selectedMethod = (-1).obs;
  final box = GetStorage();
  var url = dotenv.env['base_url'];

  // argument dari SPP
  var bulan = ''.obs;
  var tahun = ''.obs;
  var jenis = ''.obs;
  var total = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args != null) {
      bulan.value = args['bulan'] ?? '';
      tahun.value = args['tahun'] ?? '';
      jenis.value = args['jenis'] ?? '';
      total.value = args['total'] ?? 0;
    }

    print("ARGUMENT MASUK:");
    print("Bulan: ${bulan.value}");
    print("Tahun: ${tahun.value}");
    print("Jenis: ${jenis.value}");
    print("Total: ${total.value}");
  }

  final List<Map<String, String>> metodePembayaran = [
    {"nama": "Bank BCA", "logo": "assets/icons/BCA.png"},
    {"nama": "Bank BSI", "logo": "assets/icons/BSI.png"},
    {"nama": "Bank BRI", "logo": "assets/icons/BRI.png"},
    {"nama": "Dana", "logo": "assets/icons/DANA.png"},
    {"nama": "Indomaret", "logo": "assets/icons/INDOMARET.png"},
  ];

  Future<Map<String, dynamic>?> createWinpayVa({
    required String trxType,
    required String channel,
  }) async {
    try {
      final name = box.read('name') ?? 'Unknown User';
      final nisn = box.read('nisn') ?? '';

      final customerNo = DateTime.now().millisecondsSinceEpoch.toString();

      final body = {
        "customerNo": customerNo,
        "virtualAccountName": name,
        "nisn": nisn,
        "bulan": bulan.value,
        "tahun": tahun.value,
        "jenis": jenis.value,
        "totalAmount": {
          "value": "${total.value.toStringAsFixed(2)}",
          "currency": "IDR",
        },
        "virtualAccountTrxType": trxType,
        "additionalInfo": {"channel": channel},
      };

      print(" Request Body VA: $body");

      final res = await http.post(
        Uri.parse("$url/payments/winpay/va"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print(" Status: ${res.statusCode}");
      print(" Response: ${res.body}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        return jsonDecode(res.body);
      }

      Get.snackbar(
        "Error",
        "Gagal membuat Virtual Account (${res.statusCode})",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );

      return null;
    } catch (e) {
      print("ERROR: $e");
      Get.snackbar("Error", "Terjadi kesalahan: $e");
      return null;
    }
  }

  void pilihMetode(int index) {
    selectedMethod.value = index;
  }

  String get trxType {
    if (selectedMethod.value == 3) return "q"; // Dana
    if (selectedMethod.value == 4) return "q"; // Indomaret
    return "c"; // Lainnya VA
  }

  String get channel {
    final name = metodePembayaran[selectedMethod.value]["nama"];
    if (name!.contains("BCA")) return "BCA";
    if (name.contains("BSI")) return "BSI";
    if (name.contains("BRI")) return "BRI";
    if (name.contains("Dana")) return "DANA";
    if (name.contains("Indomaret")) return "INDOMARET";
    return "BSI";
  }
}
