import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/core/models/history_detail_models.dart';

class DetailRiwayatController extends GetxController {
  //TODO: Implement DetailRiwayatController

  var url = dotenv.env['base_url'];
  var isLoading = false.obs;
  var hitoryDetail = Rxn<DataHistory>();
  var transaksiId = 0;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    transaksiId = Get.arguments as int;
    fetchDetailRiwayat();
  }

  void fetchDetailRiwayat() async {
    try {
      isLoading.value = true;
      final res = await http.get(Uri.parse("$url/history/$transaksiId"));

      if (res.statusCode == 200) {
        final data = historyResponseFromJson(res.body);
        print("data: $data");
        hitoryDetail.value = data.data;
        print("Data: $hitoryDetail");
      } else {
        print("Error fetching transaction detail: ${res.statusCode}");
        print("Response body: ${res.body}");
      }
    } catch (e) {
      print("Error fetching transaction detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
