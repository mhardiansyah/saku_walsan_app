import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';
import '../controllers/notif_payment_controller.dart';

class NotifPaymentView extends StatelessWidget {
  const NotifPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotifPaymentController controller = Get.put(NotifPaymentController());

    final args = Get.arguments ?? {};
    controller.setStatus(args['status'] ?? 'success');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final status = controller.status.value;

          String title = '';
          String message = '';
          String buttonText = '';
          String imagePath = '';
          VoidCallback onPressed = () =>
              Get.offAllNamed(Routes.MAIN_NAVIGATION);

          switch (status) {
            case 'success':
              title = 'Pembayaran Berhasil!';
              message = 'Selamat! Pembayaran Anda telah diproses dengan sukses';
              buttonText = 'Kembali ke Beranda';
              imagePath = 'assets/images/berhasil.png';
              break;

            case 'failed':
              title = 'Pembayaran Gagal!';
              message = 'Maaf, Transaksi Anda tidak dapat diproses saat ini';
              buttonText = 'Coba Lagi';
              imagePath = 'assets/images/gagal.png';
              onPressed = () {
                Get.offAllNamed(Routes.METHOD_PEMBAYARAN);
              };
              break;

            case 'topup_failed':
              title = 'Top up Gagal!';
              message = 'Maaf, Transaksi Anda tidak dapat diproses saat ini';
              buttonText = 'Coba Lagi';
              imagePath = 'assets/images/gagal.png';
              break;

            case 'Pending':
              title = 'Memproses...';
              message = 'Harap Sabar, Kami sedang memproses pembayaran anda';
              buttonText = '';
              imagePath = '';
              onPressed = () {};
              break;

            default:
              title = 'Pembayaran Berhasil!';
              message = 'Selamat! Pembayaran Anda telah diproses dengan sukses';
              buttonText = 'Selanjutnya';
              imagePath = 'assets/images/berhasil.png';
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
            child: Column(
              children: [
                const Spacer(),

                (status == 'Pending')
                    ? Lottie.asset(
                        'assets/animations/LoadingPaymentjson',
                        height: 220,
                      )
                    : Image.asset(imagePath, height: 300, fit: BoxFit.contain),

                const SizedBox(height: 30),

                /// TITLE
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 10),

                /// MESSAGE
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),

                const Spacer(),

                /// BUTTON (kalo ada)
                if (buttonText.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
