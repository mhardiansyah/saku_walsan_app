import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class NominalController extends GetxController {
  var selectedNominal = 0.obs; // jumlah nominal
  var inputText = ''.obs;
  // var santriId = 0.obs;
  // var santriName = ''.obs;
  // var transaksiType = ''.obs;

  // final quickAmounts = [50000, 100000, 70000, 100000, 300000, 500000];
  final quickAmounts = [
    50000,
    100000,
    150000,
    200000,
    250000,
    300000,
    350000,
    400000,
    450000,
    500000,
  ];
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  var url = dotenv.env['base_url'];

  // final controllerMain = Get.find<MainNavigationController>();

  @override
  void onInit() {
    super.onInit();

    // final arguments = Get.arguments;
    // if (arguments != null) {
    //   santriId.value = arguments["santriId"] ?? 0;
    //   santriName.value = arguments["nama"] ?? 'N/A';
    //   transaksiType.value = arguments["type"] ?? 'N/A';
    // }

    // Sinkronisasi input text dengan pilihan nominal
    ever(selectedNominal, (val) {
      inputText.value = selectedNominal.value == 0
          ? ''
          : currencyFormatter.format(selectedNominal.value);
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

  // Future topUpSaldo() async {
  //   final amount = selectedNominal.value;

  //   if (amount <= 0) {
  //     Get.snackbar(
  //       'Error',
  //       'Pilih nominal yang valid',
  //       backgroundColor: Colors.red,
  //     );
  //     return;
  //   }

  //   final urlTopup = Uri.parse("$url/transaksi/top-up/${santriId.value}");

  //   try {
  //     final response = await http.post(
  //       urlTopup,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"jumlah": amount}),
  //     );
  //     final data = jsonDecode(response.body);

  //     if (response.statusCode == 201 && data['status'] == 'success') {
  //       Get.toNamed(
  //         Routes.HOME,
  //         arguments: {
  //           "nama": santriName.value,
  //           "total": amount,
  //           // "type": TransaksiType.topUp,
  //           // sudah benar
  //           "method": "Saldo", // contoh isi method biar nggak kosong
  //         },
  //       );

  //       Get.snackbar("Sukses", data['msg'] ?? "Saldo berhasil ditambahkan");
  //     } else {
  //       Get.snackbar("Error", data['msg'] ?? "Gagal top up");
  //       print("Error : $data");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Tidak dapat terhubung ke server");
  //     print("error : $e");
  //   }
  // }

  // Future tarikTunai() async {
  //   final amount = selectedNominal.value;

  //   if (amount <= 0) {
  //     Get.snackbar(
  //       'Error',
  //       'Pilih nominal yang valid',
  //       backgroundColor: Colors.red,
  //     );
  //     return;
  //   }

  //   final urlTransaksi = Uri.parse("$url/transaksi/deduct/${santriId.value}");

  //   try {
  //     final response = await http.post(
  //       urlTransaksi,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"jumlah": amount}),
  //     );
  //     final data = jsonDecode(response.body);
  //     if (response.statusCode == 201 && data['status'] == 'success') {
  //       final data = jsonDecode(response.body);

  //       Get.snackbar("Success", "Pembayaran Berhasil");
  //       Get.toNamed(
  //         Routes.FORGOT_PASSWORD,
  //         arguments: {
  //           "santriName": santriName.value,
  //           "total": amount,
  //           // "type": TransaksiType.tarikTunai,
  //           // samakan dengan view
  //           "method": "Saldo",
  //         },
  //       );
  //     } else {
  //       final error = jsonDecode(response.body);
  //       Get.snackbar("Error", "Pembayaran Gagal");
  //       print('status: ${response.statusCode}');
  //       print('Error: ${error['msg']}');
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Terjadi kesalahan");
  //     print('kesalahan: $e');
  //   }
  // }
}
