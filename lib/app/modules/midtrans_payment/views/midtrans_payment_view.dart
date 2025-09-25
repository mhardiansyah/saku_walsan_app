import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/midtrans_payment_controller.dart';

class MidtransPaymentView extends GetView<MidtransPaymentController> {
  const MidtransPaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MidtransPaymentView'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.paymentUrl.isEmpty) {
          return const Center(
            child: Text(
              'Tidak ada payment url',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        final webController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x0000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) => debugPrint('start: $url'),
              onPageFinished: (url) => debugPrint('end: $url'),
              onNavigationRequest: (request) {
                debugPrint("URL: ${request.url}");

                if (request.url.contains("#/success")) {
                  Get.snackbar(
                    'Success',
                    'Pembayaran berhasil',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );

                  // kasih delay buat user lihat snackbar
                  Future.delayed(const Duration(seconds: 2), () {
                    Get.offAllNamed(Routes.MAIN_NAVIGATION);
                  });

                  return NavigationDecision
                      .prevent; // ⛔ stop lanjut ke example.com
                }

                if (request.url.contains("failed")) {
                  Get.snackbar(
                    'Failed',
                    'Pembayaran gagal',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(controller.paymentUrl.value));
        return WebViewWidget(controller: webController);
      }),
    );
  }
}
