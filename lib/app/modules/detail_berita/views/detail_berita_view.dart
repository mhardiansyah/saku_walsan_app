import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart'; // untuk render html

import '../controllers/detail_berita_controller.dart';

class DetailBeritaView extends GetView<DetailBeritaController> {
  const DetailBeritaView({super.key});

  @override
  Widget build(BuildContext context) {
    final berita = controller.berita;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Artikel"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Gambar Utama ---
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                berita.yoastHeadJson.ogImage.first.url,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// --- Judul ---
            Text(
              berita.title.rendered,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            /// --- Tanggal & Jam ---
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(berita.date),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  DateFormat("HH:mm").format(berita.date),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// --- Isi Konten (HTML) ---
            Html(
              data: berita.content.rendered,
              style: {
                "p": Style(fontSize: FontSize(14), lineHeight: LineHeight(1.6)),
                "strong": Style(fontWeight: FontWeight.bold),
              },
            ),
          ],
        ),
      ),
    );
  }
}
