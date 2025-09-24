import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/core/models/berita_models.dart';

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
}
