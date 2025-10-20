import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/core/models/berita_models.dart';
import 'package:saku_walsan_app/app/core/models/santri_models.dart';

class HomeController extends GetxController {
  var saldo = 150000.obs;
  var topupBulanan = 500000.obs;
  var totalJajan = 200000.obs;
  var totalHutang = 50000.obs;
  var isloading = false.obs;
  var beritaList = <BeritaRespose>[].obs;

  var url = dotenv.env['base_url'];

  @override
  void onInit() {
    super.onInit();
    fecthBerita();
    final box = GetStorage();
    final santriId = box.read('santriId') ?? 0;
    if (santriId != null) {
      fecthSaldoAnak(santriId);
    }
  }

  Future fecthBerita() async {
    try {
      isloading.value = true;
      final urlBerita = Uri.parse(
        "https://smkmadinatulquran.sch.id/wp-json/wp/v2/posts",
      );
      final respose = await http.get(urlBerita);
      if (respose.statusCode == 200) {
        final List data = jsonDecode(respose.body);
        print("data berita: $data");
        beritaList.value = data.map((e) => BeritaRespose.fromJson(e)).toList();
      }
    } catch (e) {
      print("error fetch berita: $e");
    } finally {
      isloading.value = false;
    }
  }

  Future fecthSaldoAnak(int santriId) async {
    try {
      isloading.value = true;
      final urlSaldo = Uri.parse("${url}/santri/detail/${santriId}");
      final response = await http.get(
        urlSaldo,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final santri = Santri.fromJson(data);

        saldo.value = santri.saldo ?? 0;
        totalHutang.value = santri.hutang ?? 0;
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch saldo anak',
          backgroundColor: Colors.red,
        );
        print('Kode status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print("error fetch saldo anak: $e");
    } finally {
      isloading.value = false;
    }
  }
}
