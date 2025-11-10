import 'package:get/get.dart';

class MethodPembayaranController extends GetxController {
  var selectedMethod = (-1).obs;

  final List<Map<String, String>> metodePembayaran = [
    {"nama": "Bank BCA", "logo": "assets/icons/BCA.png"},
    {"nama": "Bank BSI", "logo": "assets/icons/BSI.png"},
    {"nama": "Bank BRI", "logo": "assets/icons/BRI.png"},
    {"nama": "Dana", "logo": "assets/icons/DANA.png"},
    {"nama": "Indomaret", "logo": "assets/icons/INDOMARET.png"},
  ];

  void pilihMetode(int index) {
    selectedMethod.value = index;
  }
}
