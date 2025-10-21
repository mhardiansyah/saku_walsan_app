// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:saku_walsan_app/app/modules/detail_riwayat_transaksi/controllers/detail_riwayat_transaksi_controller.dart';

// class DetailRiwayatTransaksiView
//     extends GetView<DetailRiwayatTransaksiController> {
//   const DetailRiwayatTransaksiView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Get.back(),
//         ),
//         title: const Text(
//           'Riwayat',
//           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final data = controller.historyDetail.value;
//         if (data == null) {
//           return const Center(child: Text("Data tidak ditemukan"));
//         }

//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Foto + Status
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.grey[200],
//                   child: const Icon(Icons.person, size: 40, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: data.status == "hutang"
//                         ? Colors.red[100]
//                         : Colors.green[100],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     data.status == "hutang" ? "Hutang" : "Lunas",
//                     style: TextStyle(
//                       color: data.status == "hutang"
//                           ? Colors.red
//                           : Colors.green[700],
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Detail Info
//                 _buildRow("Nama:", data.santri.name),
//                 _buildRow(
//                   "Tanggal Transaksi:",
//                   DateFormat("dd MMMM yyyy", "id_ID").format(data.createdAt),
//                 ),
//                 _buildRow(
//                   "Waktu Beli:",
//                   DateFormat("HH.mm", "id_ID").format(data.createdAt) + " WIB",
//                 ),
//                 _buildRow("Jumlah Bayar:", formatRupiah(data.totalAmount)),

//                 const SizedBox(height: 12),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Barang yang dibeli:",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 6),

//                 // List Items
//                 ...data.items.map(
//                   (item) => Padding(
//                     padding: const EdgeInsets.only(left: 12, bottom: 4),
//                     child: Row(
//                       children: [
//                         const Text("• "),
//                         Expanded(child: Text(item.item?.nama ?? "-")),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 8),
//                 _buildRow("Jumlah yang dibeli:", data.items.length.toString()),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Expanded(flex: 3, child: Text(label)),
//           Expanded(
//             flex: 5,
//             child: Text(
//               value,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String formatRupiah(int amount) {
//     final formatCurrency = NumberFormat.currency(
//       locale: 'id_ID',
//       symbol: 'Rp',
//       decimalDigits: 0,
//     );
//     return formatCurrency.format(amount);
//   }
// }
