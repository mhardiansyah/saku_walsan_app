import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:saku_walsan_app/app/modules/detail_berita/controllers/detail_berita_controller.dart';

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
      appBar: AppBar(title: const Text("Detail Berita")),
      body: Column(
        children: [
          Text(berita.title.rendered),
          Text(berita.content.rendered.replaceAll(RegExp(r'<[^>]*>'), '')),
        ],
      ),
    );
  }
}
