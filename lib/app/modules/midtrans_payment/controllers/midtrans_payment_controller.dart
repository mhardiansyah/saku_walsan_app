import 'package:get/get.dart';

class MidtransPaymentController extends GetxController {
  //TODO: Implement MidtransPaymentController

  final count = 0.obs;
  var paymentUrl = ''.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['url'] != null) {
      paymentUrl.value = Get.arguments['url'];
    }
    print('paymentUrl: $paymentUrl');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
