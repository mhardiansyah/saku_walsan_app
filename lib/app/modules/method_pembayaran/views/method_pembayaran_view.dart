import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/method_pembayaran_controller.dart';

class MethodPembayaranView extends StatelessWidget {
  final MethodPembayaranController c = Get.put(MethodPembayaranController());

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

          /// LIST METODE
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: c.metodePembayaran.length,
              itemBuilder: (context, index) {
                final metode = c.metodePembayaran[index];
                return GestureDetector(
                  onTap: () => c.pilihMetode(index),
                  child: Container(
                    height: 80, 
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(metode["logo"]!, height: 45),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            metode["nama"]!,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                        ),

                        /// Reaktif hanya di bagian icon
                        Obx(() {
                          final isSelected =
                              c.selectedMethod.value == index;
                          return Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            size: 28,
                            color: isSelected ? Colors.orange : Colors.grey,
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// TOMBOL BAYAR
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: c.selectedMethod.value == -1
                      ? null
                      : () {
                          final pilih = c.metodePembayaran[c.selectedMethod.value]["nama"];
                          Get.snackbar("Berhasil", "Anda memilih $pilih",
                              snackPosition: SnackPosition.BOTTOM);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF22AD61),
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
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
