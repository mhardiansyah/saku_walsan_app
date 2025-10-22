import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/core/models/history_detail_models.dart';
import 'package:saku_walsan_app/app/core/models/items_models.dart';
import 'package:saku_walsan_app/app/modules/riwayat_transaksi/controllers/riwayat_transaksi_controller.dart';

class DetailRiwayatTransaksiController extends GetxController {
  var url = dotenv.env['base_url'];
  var isLoading = false.obs;

  var historyDetail = Rxn<DataHistory>();
  final riwayatController = Get.find<RiwayatTransaksiController>();
  // var allItems = <Items>[];
  var transaksiId = 0;

  @override
  void onInit() {
    super.onInit();
    transaksiId = Get.arguments as int;
    fetchDetailRiwayat();
    // fetchProduct();
  }

  Future<void> fetchDetailRiwayat() async {
    try {
      isLoading.value = true;
      final res = await http.get(Uri.parse("$url/history/$transaksiId"));
      if (res.statusCode == 200) {
        final data = historyResponseFromJson(res.body);
        historyDetail.value = data.data;
      } else {
        Get.snackbar("Error", "Gagal ambil detail transaksi");
      }
    } catch (e) {
      Get.snackbar("Error", "Error fetch detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String getProductName(int itemId) {
    final product = riwayatController.allItems.firstWhereOrNull(
      (p) => p.id == itemId,
    );
    return product?.nama ?? "Produk #$itemId";
  }
}
