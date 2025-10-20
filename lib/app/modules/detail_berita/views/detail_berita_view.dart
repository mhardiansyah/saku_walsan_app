import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import '../controllers/detail_berita_controller.dart';

class DetailBeritaView extends GetView<DetailBeritaController> {
  const DetailBeritaView({super.key});

  @override
  Widget build(BuildContext context) {
    final berita = controller.berita;

    if (berita == null) {
      return const Scaffold(
        body: Center(child: Text("Data berita tidak ditemukan")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Artikel"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Gambar utama (featured image) ---
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                berita.yoastHeadJson.ogImage.isNotEmpty
                    ? berita.yoastHeadJson.ogImage.first.url
                    : "https://via.placeholder.com/400x200.png?text=No+Image",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            /// --- Judul ---
            Text(
              berita.title.rendered,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

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
                  DateFormat("HH.mm").format(berita.date),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// --- Isi Berita (HTML + gambar responsif) ---
            Html(
              data: berita.content.rendered,
              style: {
                "p": Style(
                  fontSize: FontSize(14),
                  color: Colors.black87.withOpacity(0.7),
                  lineHeight: LineHeight(1.5),
                ),
                "img": Style(
                  width: Width(MediaQuery.of(context).size.width), // full width
                ),
              },
              extensions: [
                ImageExtension(
                  builder: (context) {
                    final buildCtx = context.buildContext;
                    final attrs = context.attributes ?? <String, String>{};
                    final src = attrs['src'] ?? '';

                    if (src.isEmpty || buildCtx == null) {
                      // no src or no BuildContext -> return safe fallback
                      return const SizedBox.shrink();
                    }

                    final width = MediaQuery.of(buildCtx).size.width;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          src,
                          width: width,
                          fit: BoxFit.contain,
                          errorBuilder: (ctx, error, stackTrace) => Container(
                            color: Colors.grey[300],
                            height: 180,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
