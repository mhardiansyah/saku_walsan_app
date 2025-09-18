import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_notifikasi_controller.dart';

class DetailNotifikasiView extends GetView<DetailNotifikasiController> {
  const DetailNotifikasiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailNotifikasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailNotifikasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
