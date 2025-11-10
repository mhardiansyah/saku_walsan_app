import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/core/models/spp_models.dart';

class SppController extends GetxController {
  var selectedMonth = ''.obs;
  var isloading = false.obs;
  var sppList = <Spp>[].obs;

  var paidcount = 0.obs;
  var unpaidcount = 0.obs;

  //utils
  final box = GetStorage();

  final months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  void onInit() {
    final nisn = box.read('nisn') ?? '';
    if (nisn.isNotEmpty) {
      fetchSpp(nisn);
    }
    super.onInit();
  }

  Future fetchSpp(String nisn) async {
    try {
      isloading.value = true;
      final urlSpp = Uri.parse(
        "https://lap-uang-be.vercel.app/arrears/student/$nisn",
      );
      final res = await http.get(urlSpp);
      if (res.statusCode == 200) {
        sppList.value = sppFromJson(res.body);
        paidcount.value = sppList.where((e) => e.status == "LUNAS").length;
        unpaidcount.value = sppList
            .where((e) => e.status == "BELUM LUNAS")
            .length;
        Get.snackbar(
          "Success",
          "Berhasil memuat data",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Gagal memuat data ${res.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("error fetch spp: $e");
    } finally {
      isloading.value = false;
    }
  }
}
