import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_riwayat_controller.dart';

class DetailRiwayatView extends GetView<DetailRiwayatController> {
  const DetailRiwayatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailRiwayatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailRiwayatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
