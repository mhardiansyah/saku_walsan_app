import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';
import '../controllers/method_pembayaran_controller.dart';

class MethodPembayaranView extends GetView<MethodPembayaranController> {
  const MethodPembayaranView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Metode Pembayaran",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            "Pilih Metode Sesuai anda",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: controller.metodePembayaran.length,
              itemBuilder: (context, index) {
                final metode = controller.metodePembayaran[index];
                return GestureDetector(
                  onTap: () => controller.pilihMetode(index),
                  child: Container(
                    height: 90, // dibuat lebih tinggi biar mirip desain
                    margin: const EdgeInsets.only(bottom: 18),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // LOGO
                        Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Image.asset(
                            metode["logo"]!,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 20),

                        // NAMA BANK
                        Expanded(
                          child: Text(
                            metode["nama"]!,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // RADIO BUTTON
                        Obx(() {
                          final isSelected =
                              controller.selectedMethod.value == index;

                          return Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.orange : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 13,
                                      height: 13,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  )
                                : null,
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.selectedMethod.value == -1
                      ? null
                      : () async {
                          Get.toNamed(
                            Routes.NOTIF_PAYMENT,
                            arguments: {"status": "Pending"},
                          );

                          print("MULAI PROSES CREATE WINPAY VA...");
                          print(
                            "Metode dipilih: ${controller.metodePembayaran[controller.selectedMethod.value]["nama"]}",
                          );
                          print("Bulan : ${controller.bulan.value}");
                          print("Tahun : ${controller.tahun.value}");
                          print("Jenis : ${controller.jenis.value}");
                          print("Total : ${controller.total.value}");
                          print("trxType : ${controller.trxType}");
                          print("channel : ${controller.channel}");

                          final result = await controller.createWinpayVa(
                            trxType: controller.trxType,
                            channel: controller.channel,
                          );

                          print("HASIL CREATE VA:");
                          print(result);

                          if (result == null) {
                            Get.offAllNamed(
                              Routes.NOTIF_PAYMENT,
                              arguments: {"status": "failed"},
                            );
                            return;
                          }

                          final vaData = result;
                          Get.offNamed(
                            Routes.PEMBAYARAN,
                            arguments: {
                              "channel": vaData["additionalInfo"]["channel"],

                              "trxType": controller.trxType,
                              "va_number": vaData["virtualAccountNo"],
                              "va_name": vaData["virtualAccountName"],
                              "expired": vaData["expiredDate"],
                              "total": vaData["totalAmount"]["value"],

                              "contractId":
                                  vaData["additionalInfo"]["contractId"],
                              "trxId": vaData["trxId"],
                            },
                          );
                        },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedMethod.value == -1
                        ? Colors.grey.shade300
                        : const Color(0xFF22AD61),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),

                  child: const Text(
                    "Bayar",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
