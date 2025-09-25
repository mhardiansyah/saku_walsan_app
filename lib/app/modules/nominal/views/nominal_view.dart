import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/nominal_controller.dart';

class NominalView extends StatelessWidget {
  NominalView({super.key});

  final NominalController controller = Get.put(NominalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4634CC)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Top Up',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? constraints.maxWidth * 0.2 : 24,
            ),
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  "Pilih nominal",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Input nominal reactive
                SizedBox(
                  width: isDesktop ? 600 : 400,
                  child: TextField(
                    controller: controller.textController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: controller.updateNominalFromText,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "Masukkan nominal",
                      hintStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black38),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Jumlah cepat
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jumlah cepat*",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final selectedNominal =
                            controller.selectedNominal.value;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.quickAmounts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isDesktop ? 4 : 2,
                                childAspectRatio: 3.0,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemBuilder: (context, index) {
                            final amount = controller.quickAmounts[index];
                            final isSelected = selectedNominal == amount;

                            return OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: isSelected
                                    ? Colors.green[300]
                                    : Colors.grey[300],
                                side: const BorderSide(color: Colors.white54),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => controller.pilihNominal(amount),
                              child: Text(
                                amount >= 1000
                                    ? '${amount ~/ 1000}ribu'
                                    : amount.toString(),
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22AD61),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: controller.isloading.value
                  ? () {}
                  : () async {
                      controller.topUpSaldo();
                      debugPrint(
                        "Nominal dipilih: ${controller.selectedNominal.value}",
                      );
                    },
              child: controller.isloading.value
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      "Top Up",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
