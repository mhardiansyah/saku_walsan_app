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
  var bulan = <String>[].obs;
  var tahun = ''.obs;
  var jenis = ''.obs;
  var total = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args != null) {
      bulan.assignAll(args['bulan'] ?? []);
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
    {"nama": "Bank BSI", "logo": "assets/icons/BSI.png"},
    {"nama": "Bank BRI", "logo": "assets/icons/BRI.png"},
    {"nama": "Bank Muamalat", "logo": "assets/icons/muamalat.png"},
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

        // 🟢 BULAN SEKARANG LIST, BUKAN STRING
        "bulan": bulan.toList(),

        "tahun": tahun.value,
        "jenis": jenis.value,
        "totalAmount": {
          "value": "${total.value.toStringAsFixed(2)}",
          "currency": "IDR",
        },
        "virtualAccountTrxType": trxType,
        "additionalInfo": {"channel": channel},
      };

      print(" REQUEST BODY WINPAY: $body");

      final res = await http.post(
        Uri.parse("$url/payments/winpay/va"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "User-Agent": "PostmanRuntime/7.33.0",
          "Accept-Encoding": "identity", // <-- FIX VERCEL EMPTY BODY
        },
        body: jsonEncode(body),
      );

      print(" STATUS: ${res.statusCode}");
      print(" RESPONSE: ${res.body}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        if (res.body.isEmpty) {
          print("⚠️ WARNING: Response kosong dari server!!!");
          return {"message": "Created but no content"};
        }

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
    final name = metodePembayaran[selectedMethod.value]["nama"]!.toUpperCase();

    if (name.contains("BSI")) return "BSI";
    if (name.contains("BRI")) return "BRI";
    if (name.contains("MUAMALAT")) return "MUAMALAT";

    // default fallback biar aman
    return "BSI";
  }
}
