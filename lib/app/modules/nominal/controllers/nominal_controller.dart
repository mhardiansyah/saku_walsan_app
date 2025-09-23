import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/core/types/transaksi_type.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class NominalController extends GetxController {
  var selectedNominal = 0.obs;
  var inputText = ''.obs;
  var santriId = 0.obs;
  var santriName = ''.obs;
  var transaksiType = TransaksiType.topUp.obs; // hanya untuk topUp

  final quickAmounts = [100000, 200000, 300000, 400000, 500000, 600000];
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  var url = dotenv.env['base_url'];

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    if (arguments != null) {
      santriId.value = arguments["santriId"] ?? 0;
      santriName.value = arguments["santriName"] ?? 'N/A';
    }

    ever(selectedNominal, (val) {
      inputText.value =
          selectedNominal.value == 0 ? '' : currencyFormatter.format(selectedNominal.value);
    });
  }

  void pilihNominal(int amount) {
    selectedNominal.value = amount;
  }

  void updateNominalFromText(String value) {
    String numeric = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeric.isNotEmpty) {
      selectedNominal.value = int.parse(numeric);
    } else {
      selectedNominal.value = 0;
    }
  }

  Future<void> topUpSaldo() async {
    final amount = selectedNominal.value;

    if (amount <= 0) {
      Get.snackbar('Error', 'Pilih nominal yang valid', backgroundColor: Colors.red);
      return;
    }

    final urlTopup = Uri.parse("$url/transaksi/top-up/${santriId.value}");

    try {
      final response = await http.post(
        urlTopup,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"jumlah": amount}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['status'] == 'success') {
        // Get.toNamed(
        //   Routes.NOTIF_PEMBAYARAN,
        //   arguments: {
        //     "santriName": santriName.value,
        //     "total": amount,
        //     "type": TransaksiType.topUp,
        //     "method": "Saldo",
        //   },
        // );

        Get.snackbar("Sukses", data['msg'] ?? "Saldo berhasil ditambahkan");
      } else {
        Get.snackbar("Error", data['msg'] ?? "Gagal top up");
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server");
      debugPrint("error : $e");
    }
  }
}
