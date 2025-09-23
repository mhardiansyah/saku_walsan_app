import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:saku_walsan_app/app/routes/app_pages.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotifikasiController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hari Ini",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            // List Notifikasi
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.notifikasiList.length,
                  itemBuilder: (context, index) {
                    final notif = controller.notifikasiList[index];

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_NOTIFIKASI, arguments: notif);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:  Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar bulat
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 20,
                              child: Text(
                                notif.sender[0], // ambil huruf pertama
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                      
                            // Konten Notifikasi
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        notif.sender,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            notif.date,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          if (!notif.isRead)
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF1B8A4E),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notif.message,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
