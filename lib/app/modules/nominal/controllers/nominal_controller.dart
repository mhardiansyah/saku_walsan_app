import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/core/models/santri_models.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class NominalController extends GetxController {
  var selectedNominal = 0.obs; // jumlah nominal
  final textController = TextEditingController();
  var inputText = ''.obs;
  var parentId = 0.obs;
  var santriId = 0.obs;
  var isloading = false.obs;

  final quickAmounts = [200000, 300000, 400000, 500000];
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  var url = dotenv.env['base_url'];
  final box = GetStorage();

  // final controllerMain = Get.find<MainNavigationController>();

  @override
  void onInit() {
    super.onInit();
    var savedSantriId = box.read('santriId');
    santriId.value = savedSantriId != null
        ? int.tryParse(savedSantriId.toString()) ?? 0
        : 0;

    print('Santri ID in NominalController: ${santriId.value}');

    ever(inputText, (val) {
      textController.value = TextEditingValue(
        text: val,
        selection: TextSelection.collapsed(offset: val.length),
      );
    });

    // Sinkronisasi inputText dengan nominal
    ever(selectedNominal, (val) {
      inputText.value = selectedNominal.value == 0
          ? ''
          : currencyFormatter.format(selectedNominal.value);
    });
  }

  void pilihNominal(int amount) {
    selectedNominal.value = amount;
  }

  void setData(Kartu data) {
    santriId.value = data.data.santri.id;
  }

  void updateNominalFromText(String value) {
    String numeric = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeric.isNotEmpty) {
      selectedNominal.value = int.parse(numeric);
    } else {
      selectedNominal.value = 0;
    }
  }

  Future topUpSaldo() async {
    isloading.value = true;
    final amount = selectedNominal.value;

    if (amount <= 0) {
      Get.snackbar(
        'Error',
        'Pilih nominal yang valid',
        backgroundColor: Colors.red,
      );
      return;
    }

    final orderId = DateTime.now().millisecondsSinceEpoch.toString();

    final body = {"santriId": santriId.value, "grossAmount": amount};

    final urlTopup = Uri.parse("$url/midtrans/create-transaction");

    try {
      final response = await http.post(
        urlTopup,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        final transaction = data['data'];
        final redirectUrl = transaction['redirect_url'];
        if (redirectUrl != null) {
          Get.toNamed(Routes.MIDTRANS_PAYMENT, arguments: {"url": redirectUrl});
        }

        Get.snackbar("Sukses", data['msg'] ?? "Transaksi berhasil di buat");
      } else {
        Get.snackbar("Error", data['msg'] ?? "Gagal top up");
        print("Error : $data");
        debugPrint("Error response: $data");
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server");
      print("error : $e");
      debugPrint("Error response: $e");
    } finally {
      isloading.value = false;
    }
  }

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