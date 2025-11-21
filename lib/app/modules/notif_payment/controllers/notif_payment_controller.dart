import 'package:get/get.dart';

class NotifPaymentController extends GetxController {
  // Menyimpan status notifikasi: success, failed, topup_failed
  final status = ''.obs;

  // Setter untuk mengatur status dari luar
  void setStatus(String value) {
    status.value = value;
  }
}
