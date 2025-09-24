class Items {
  int id;
  String nama;
  int harga;
  int? kategoriId;
  int jumlah;
  String gambar;
  String? barcode;
  DateTime createdAt;
  DateTime updatedAt;

  Items({
    required this.id,
    required this.nama,
    required this.harga,
    required this.kategoriId,
    required this.jumlah,
    required this.gambar,
    required this.barcode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["id"] ?? 0,
    nama: json["nama"] ?? '',
    harga: json["harga"] ?? 0,
    kategoriId: json["kategori_id"],
    jumlah: json["jumlah"] ?? 0,
    gambar: json["gambar"] ?? '',
    barcode: json["barcode"] ?? '',
    createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updated_at"] ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "harga": harga,
    "kategori_id": kategoriId,
    "jumlah": jumlah,
    "gambar": gambar,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
