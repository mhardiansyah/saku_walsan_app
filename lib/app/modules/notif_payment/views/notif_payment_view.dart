import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notif_payment_controller.dart';

class NotifPaymentView extends StatelessWidget {
  const NotifPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotifPaymentController controller = Get.put(NotifPaymentController());

    // Ambil status dari argument
    final args = Get.arguments ?? {};
    controller.setStatus(args['status'] ?? 'success');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final status = controller.status.value;

          // Variabel UI dinamis
          String title = '';
          String message = '';
          String buttonText = '';
          String imagePath = '';
          VoidCallback onPressed = () => Get.back();

          switch (status) {
            case 'success':
              title = 'Pembayaran Berhasil!';
              message = 'Selamat! Pembayaran Anda telah diproses dengan sukses';
              buttonText = 'Selanjutnya';
              imagePath = 'assets/icons/payment_success.png';
              break;

            case 'failed':
              title = 'Pembayaran Gagal!';
              message = 'Maaf, Transaksi Anda tidak dapat diproses saat ini';
              buttonText = 'Coba Lagi';
              imagePath = 'assets/icons/topup_failed.png';
              break;

            case 'topup_failed':
              title = 'Top up Gagal!';
              message = 'Maaf, Transaksi Anda tidak dapat diproses saat ini';
              buttonText = 'Coba Lagi';
              imagePath = 'assets/icons/topup_failed.png';
              break;

            default:
              title = 'Pembayaran Berhasil!';
              message = 'Selamat! Pembayaran Anda telah diproses dengan sukses';
              buttonText = 'Selanjutnya';
              imagePath = 'assets/icons/payment_success.png';
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
            child: Column(
              children: [
                const Spacer(),

                /// GAMBAR
                Image.asset(
                  imagePath,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),

                /// JUDUL
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

                /// PESAN
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

                /// TOMBOL DI PALING BAWAH
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
