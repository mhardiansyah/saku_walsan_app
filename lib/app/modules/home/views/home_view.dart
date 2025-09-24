import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userName = box.read('name') ?? 'User';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1B8A4E),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: getRandomColor(1),
              child: Text(
                getInitials(userName),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello $userName",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    "Wali santri",
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: const [
                  Text(
                    "Hari ini",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.notifications_none, color: Colors.white),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// --- SALDO ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF1B8A4E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, 
                children: [
                  const Text(
                    "Transaksi anak Hari ini:",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "RP. 10.000.000",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// tombol rata kiri
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.list, color: Colors.white),
                      label: const Text(
                        "Lihat Detail",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// --- 3 CARD ---
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
              children: [
                _buildSummaryCard(
                  "Total Transaksi",
                  "20",
                  Colors.green,
                  "assets/icons/dolars.png",
                  "+10",
                ),
                _buildSummaryCard(
                  "Total Kasbon",
                  "300K",
                  Colors.red,
                  "assets/icons/kasbon.png",
                  "+10",
                ),
                _buildSummaryCard(
                  "Total Top up",
                  "20",
                  Colors.blue,
                  "assets/icons/dolars.png",
                  "+10",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    Color color,
    String imagePath,
    String badge,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Icon + Title sejajar ---
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF2CC), // krem/kuning muda
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      width: 18,
                      height: 18,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// --- Value + Badge sejajar ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color, // warna badge mengikuti card
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getInitials(String name) {
    if (name.isEmpty) return "";
    List<String> parts = name.split(" ");
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    } else {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
  }

  Color getRandomColor(int seed) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.indigo,
    ];
    return colors[seed % colors.length];
  }
}