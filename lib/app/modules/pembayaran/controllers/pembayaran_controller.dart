import 'dart:convert';
import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class PembayaranController extends GetxController {
  var channel = "".obs;
  var trxType = "".obs;
  var vaNumber = "".obs;
  var vaName = "".obs;
  var expired = "".obs;
  var total = "".obs;
  var contractId = "".obs;
  var trxId = "".obs;
  var countdownText = "00:00:00".obs;

  var url = dotenv.env['base_url'];

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    channel.value = args["channel"] ?? "";
    trxType.value = args["trxType"] ?? "";
    vaNumber.value = args["va_number"] ?? "-";
    vaName.value = args["va_name"] ?? "-";
    expired.value = args["expired"] ?? "-";
    total.value = args["total"]?.toString() ?? "0";
    contractId.value = args["contractId"] ?? "";
    trxId.value = args["trxId"] ?? "";

    startCountdown();

    print("DATA MASUK KE PEMBAYARAN VIEW:");
    print(args);
  }

  void startCountdown() async {
    if (expired.value == "-") return;

    try {
      DateTime exp = DateTime.parse(expired.value);

      Timer.periodic(const Duration(seconds: 1), (timer) {
        final now = DateTime.now();
        final diff = exp.difference(now);

        if (diff.inSeconds <= 0) {
          countdownText.value = "Expired";
          timer.cancel();
          return;
        }
        final hours = diff.inHours.toString().padLeft(2, '0');
        final minutes = (diff.inMinutes % 60).toString().padLeft(2, '0');
        final seconds = (diff.inSeconds % 60).toString().padLeft(2, '0');
        countdownText.value = "$hours:$minutes:$seconds";
      });
    } catch (e) {
      print("ERROR START COUNTDOWN: $e");
    }
  }

  String getLogoByChannel() {
    final bank = channel.value.toUpperCase();

    if (bank.contains("BSI")) return "assets/icons/BSI.png";
    if (bank.contains("BRI")) return "assets/icons/BRI.png";
    if (bank.contains("MUAMALAT")) return "assets/icons/muamalat.png";

    return "assets/icons/BSI.png";
  }

  void refreshData() async {
    print("REFRESH KLIK — cek status pembayaran...");

    final urlCekStatus = Uri.parse("$url/payments/winpay/va/inquiry-status");

    final body = {
      "virtualAccountNo": vaNumber.value,
      "additionalInfo": {
        "channel": channel.value,
        "contractId": contractId.value,
        "trxId": trxId.value,
      },
    };

    print("➡ URL: $urlCekStatus");
    print("➡ BODY: $body");

    try {
      final res = await http.post(
        urlCekStatus,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("⬅ RESPONSE CODE: ${res.statusCode}");
      print("⬅ RESPONSE BODY: ${res.body}");

      final json = jsonDecode(res.body);
      if (json["message"] != null && json["data"] == null) {
        Get.snackbar(
          "Server Error",
          json["message"] ?? "Terjadi kesalahan saat cek status.",
        );
        return;
      }

      if (json["data"] == null) {
        Get.snackbar(
          "Error",
          "Format respons tidak sesuai. Tidak ada field 'data'.",
        );
        return;
      }

      final data = json["data"];
      final vaData = data["virtualAccountData"];

      if (vaData == null) {
        Get.snackbar("Error", "Data VA tidak ditemukan di respons.");
        return;
      }

      final flag = vaData["paymentFlagStatus"];
      print(" PAYMENT FLAG: $flag");

      switch (flag) {
        case "00":
          Get.snackbar("Pembayaran Berhasil ", "Transaksi sudah dibayar.");
          Get.offNamed(Routes.NOTIF_PAYMENT, arguments: {"status": "Success"});
          break;

        case "01":
          Get.snackbar("Belum Dibayar", "Transaksi belum diterima.");
          break;

        case "02":
          Get.snackbar("Expired", "Kode VA sudah kedaluwarsa.");
          break;

        case "03":
          Get.snackbar("Dibatalkan", "Transaksi dibatalkan.");
          break;

        default:
          Get.snackbar("Status Tidak Dikenal", "Flag: $flag");
      }
    } catch (e) {
      print("ERROR CEK STATUS: $e");
      Get.snackbar("Error", "Tidak dapat menghubungi server");
    }
  }
}
