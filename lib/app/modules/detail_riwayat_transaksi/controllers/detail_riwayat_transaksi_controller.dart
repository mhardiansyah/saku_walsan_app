import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/core/models/history_detail_models.dart';
import 'package:saku_walsan_app/app/core/models/items_models.dart';

class DetailRiwayatTransaksiController extends GetxController {
  var url = dotenv.env['base_url'];
  var isLoading = false.obs;

  var historyDetail = Rxn<DataHistory>();
  var allItems = <Items>[]; // simpan semua produk
  var transaksiId = 0;

  @override
  void onInit() {
    super.onInit();
    transaksiId = Get.arguments as int;
    fetchDetailRiwayat();
    fetchProduct();
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

  Future<void> fetchProduct() async {
    try {
      final urlItems = Uri.parse("$url/items");
      final response = await http.get(urlItems);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonresponse = json.decode(response.body);
        final List<dynamic> data = jsonresponse['data'];
        print("Products data: $data");
        allItems = data.map((item) => Items.fromJson(item)).toList();
      } else {
        Get.snackbar('Error', 'Gagal ambil data produk');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed fetch: $e', backgroundColor: Colors.red);
    }
  }

  /// helper buat cari nama produk dari itemId
  String getProductName(int itemId) {
    final product = allItems.firstWhereOrNull((p) => p.id == itemId);
    return product?.nama ?? "Produk #$itemId";
  }
}
