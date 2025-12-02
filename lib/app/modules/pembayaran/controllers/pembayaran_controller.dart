import 'package:get/get.dart';

class PembayaranController extends GetxController {
  var channel = "".obs;
  var trxType = "".obs;
  var vaNumber = "".obs;
  var vaName = "".obs;
  var expired = "".obs;
  var total = "".obs;

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

    print("DATA MASUK KE PEMBAYARAN VIEW:");
    print(args);
  }

  String getLogoByChannel() {
    final bank = channel.value.toUpperCase();

    if (bank.contains("BSI")) return "assets/icons/BSI.png";
    if (bank.contains("BRI")) return "assets/icons/BRI.png";
    if (bank.contains("MUAMALAT")) return "assets/icons/muamalat.png";

    return "assets/icons/default_bank.png"; // fallback kalau error
  }

  void refreshData() {
  print("REFRESH KLIK — anda bisa tambahkan GET STATUS API disini nanti");
}

}
