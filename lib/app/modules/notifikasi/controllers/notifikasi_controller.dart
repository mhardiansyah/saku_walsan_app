import 'package:get/get.dart';

class Notifikasi {
  final String sender;
  final String message;
  final String date;
  final bool isRead;

  Notifikasi({
    required this.sender,
    required this.message,
    required this.date,
    this.isRead = false,
  });
}

class NotifikasiController extends GetxController {
  // Data dummy notifikasi
  var notifikasiList = <Notifikasi>[
    Notifikasi(
      sender: "Admin",
      message: "Berikut Transferan saldo untuk...",
      date: "11 Jan, 2025",
      isRead: false,
    ),
    Notifikasi(
      sender: "Admin",
      message: "Saldo anda sudah ditambahkan.",
      date: "11 Jan, 2025",
      isRead: false,
    ),
    Notifikasi(
      sender: "Admin",
      message: "Jangan lupa untuk update aplikasi.",
      date: "11 Jan, 2025",
      isRead: true,
    ),
  ].obs;

  // Tandai notifikasi sudah dibaca
  void markAsRead(int index) {
    notifikasiList[index] = Notifikasi(
      sender: notifikasiList[index].sender,
      message: notifikasiList[index].message,
      date: notifikasiList[index].date,
      isRead: true,
    );
  }

  // Hapus notifikasi
  void removeNotifikasi(int index) {
    notifikasiList.removeAt(index);
  }
}
