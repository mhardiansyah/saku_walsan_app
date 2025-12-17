// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:saku_walsan_app/app/modules/spp/controllers/spp_controller.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

class SppView extends GetView<SppController> {
  const SppView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final nisn = box.read('nisn') ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'SPP',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.fetchSpp(nisn);
        },
        color: const Color(0xFF22C55E),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          title: "Pembayaran yang\nSudah Terbayar",
                          count: controller.paidCount.value.toString(),
                          color: const Color(0xFF22C55E),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          title: "Pembayaran yang\nBelum Terbayar",
                          count: controller.unpaidCount.value.toString(),
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Riwayat Pembayaran",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),

                _buildHistoryItem(
                  name: "Tidak Ada Data",
                  date: "-",
                  amount: "-",
                  imageUrl: "https://i.pravatar.cc/150?img=1",
                ),

                const SizedBox(height: 24),

                Obx(() {
                  final step = controller.step.value;
                  final sudahPilihBulan =
                      controller.selectedJenis.value == "OTHER" ||
                      controller.selectedMonths.isNotEmpty;

                  if (step < 3 || !sudahPilihBulan) {
                    String placeholder;
                    if (step == 1) {
                      placeholder = "Silahkan Pilih Jenis Pembayaran";
                    } else if (step == 2) {
                      placeholder = "Silahkan Pilih Tahun Pembayaran";
                    } else {
                      placeholder = "Silahkan Pilih Bulan Pembayaran";
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pembayaran",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            if (step == 1) {
                              _showJenisDialog(context, controller);
                            } else if (step == 2) {
                              _showTahunDialog(context, controller);
                            } else {
                              _showMonthPickerDialog(context, controller);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  placeholder,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pembayaran",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showJenisDialog(context, controller),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Pilih jenis",
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            _showMonthPickerDialog(context, controller),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Pilih bulan",
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 16),

                Obx(() {
                  if (controller.step.value != 4) return const SizedBox();

                  // ===================== JIKA OTHER =====================
                  if (controller.selectedJenis.value == "OTHER" &&
                      controller.selectedOtherPayment.value != null) {
                    final other = controller.selectedOtherPayment.value!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ===== KOTAK OTHER (MIRIP SPP) =====
                        Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // ✅ CHECK ICON (SELALU AKTIF)
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatRupiah(other.amount),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          other.type.name,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.orange.shade300,
                                      ),
                                    ),
                                    child: const Text(
                                      "OTHER",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // OPTIONAL: CICILAN JUGA BISA
                              TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Silahkan Masukan Cicilan",
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ===== RINGKASAN (PAKAI YANG SAMA) =====
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B8A4E),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Ringkasan:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Column(
                                  children: [
                                    _summaryRow(
                                      "Biaya Pokok:",
                                      formatRupiah(
                                        controller.totalNominal.toInt(),
                                      ),
                                    ),
                                    _summaryRow(
                                      "Biaya Admin:",
                                      formatRupiah(
                                        controller.totalAdmin.toInt(),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    _summaryRow(
                                      "Total Biaya:",
                                      formatRupiah(
                                        controller.totalPembayaran.toInt(),
                                      ),
                                      bold: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  // ===================== JIKA SPP (KODE LAMA KAMU, TIDAK DIUBAH) =====================
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...controller.selectedSpp.map((item) {
                        final key = "${item.month}|${item.year}";
                        final isSelected = controller.selectedMonths.contains(
                          key,
                        );

                        final cicilanCtrl = controller.cicilanControllers
                            .putIfAbsent(key, () => TextEditingController());

                        final isLast =
                            controller.selectedMonths.isNotEmpty &&
                            key == controller.selectedMonths.last;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      final temp = [
                                        ...controller.selectedMonths,
                                      ];

                                      if (isSelected) {
                                        temp.remove(key);
                                      } else {
                                        temp.add(key);
                                      }

                                      if (!controller.isSequentialAndNoSkip(
                                        temp,
                                      )) {
                                        Get.snackbar(
                                          "Peringatan",
                                          "Harus memilih bulan secara berurutan, tidak boleh loncat.",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                        return;
                                      }

                                      controller.selectedMonths.assignAll(temp);
                                      controller.summarySelectedSpp();
                                      controller.step.value = 4;
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.orange
                                              : Colors.grey,
                                          width: 2,
                                        ),
                                        color: isSelected
                                            ? Colors.orange
                                            : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatRupiah(item.nominal),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              controller.monthName(item.month),
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              controller.selectedTahun.value,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              if (isLast)
                                TextField(
                                  controller: cicilanCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Silahkan Masukan Cicilan",
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 20),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String left, String right, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showMonthPickerDialog(BuildContext context, SppController controller) {
    controller.tempSelectedMonths.assignAll(controller.selectedMonths);

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pilih Bulan Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),

                  Obx(
                    () => Column(
                      children: controller.monthList.map((item) {
                        final isSelected = controller.tempSelectedMonths
                            .contains(item);

                        final split = item.split('|');
                        final month = split[0];
                        final year = split[1];

                        return GestureDetector(
                          onTap: () {
                            final temp = [...controller.tempSelectedMonths];

                            if (isSelected) {
                              temp.remove(item);
                            } else {
                              temp.add(item);
                            }

                            if (!controller.isSequentialAndNoSkip(temp)) {
                              Get.snackbar(
                                "Peringatan",
                                "Harus memilih bulan secara berurutan, tidak boleh loncat.",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }

                            controller.tempSelectedMonths.assignAll(temp);
                            controller.summarySelectedSpp();
                          },

                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // controller.monthName(item),
                                  "$month $year",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.orange
                                          : Colors.black,
                                      width: 2,
                                    ),
                                    color: isSelected
                                        ? Colors.orange
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      controller.selectedMonths.assignAll(
                        controller.tempSelectedMonths,
                      );
                      controller.summarySelectedSpp();
                      controller.step.value = 4;
                      Get.back();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF22C55E,
                        ), // hijau cerah kayak desain
                        borderRadius: BorderRadius.circular(
                          40,
                        ), // bikin super rounded
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Terapkan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOtherDialog(BuildContext context, SppController controller) {
    controller.tempSelectedOther.value = controller.selectedOtherPayment.value;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih Pembayaran Lainnya",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),

              Obx(
                () => Column(
                  children: controller.otherList.map((item) {
                    final isSelected =
                        controller.tempSelectedOther.value?.id == item.id;

                    return GestureDetector(
                      onTap: () {
                        controller.tempSelectedOther.value = item;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.type.name),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.orange
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: isSelected
                                    ? Colors.orange
                                    : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  controller.selectedOtherPayment.value =
                      controller.tempSelectedOther.value;
                  controller.summarySelectedOther();
                  controller.step.value = 4;
                  Get.back();
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Terapkan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJenisDialog(BuildContext context, SppController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pilih Jenis Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),

                  Obx(
                    () => Column(
                      children: controller.jenisList.map((item) {
                        final isSelected =
                            controller.selectedJenis.value == item;

                        return GestureDetector(
                          onTap: () {
                            controller.selectedJenis(item);

                            if (item == "SPP") {
                              controller.step.value = 3;
                              Get.back();
                              return;
                            }

                            if (item == "OTHER") {
                              // controller.step.value = 4;
                              Get.back();
                              _showOtherDialog(context, controller);
                              return;
                            }

                            controller.step.value = 2;
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.orange
                                          : Colors.black,
                                      width: 2,
                                    ),
                                    color: isSelected
                                        ? Colors.orange
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      controller.step.value = 2;
                      Get.back();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E), // hijau seperti desain
                        borderRadius: BorderRadius.circular(
                          40,
                        ), // biar smooth round
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Selanjutnya",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showTahunDialog(BuildContext context, SppController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pilih Tahun",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),

                  Obx(
                    () => Column(
                      children: controller.tahunList.map((item) {
                        final isSelected =
                            controller.selectedTahun.value == item;

                        return GestureDetector(
                          onTap: () {
                            controller.selectYear(item);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.orange
                                          : Colors.black,
                                      width: 2,
                                    ),
                                    color: isSelected
                                        ? Colors.orange
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      controller.step.value = 3;
                      Get.back();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        borderRadius: BorderRadius.circular(
                          40,
                        ), // biar smooth round
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Selanjutnya",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required Color color,
  }) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required String name,
    required String date,
    required String amount,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 25, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Lunas",
                  style: TextStyle(
                    color: Color(0xFF1B8A4E),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =======================
  // FORMAT RUPIAH
  // =======================
  String formatRupiah(int amount) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }
}
