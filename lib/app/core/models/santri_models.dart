import 'dart:convert';

Kartu kartuFromJson(String str) => Kartu.fromJson(json.decode(str));

class Kartu {
  String status;
  String msg;
  Data data;

  Kartu({required this.status, required this.msg, required this.data});

  factory Kartu.fromJson(Map<String, dynamic> json) {
    return Kartu(
      status: json['status'],
      msg: json['msg'],
      data: Data.fromJson(json['data']),
    );
  }
}

Data datafromJson(String str) => Data.fromJson(json.decode(str));

class Data {
  int id;
  String nomorKartu;
  String passcode;
  DateTime createdAt;
  DateTime updatedAt;
  Santri santri;

  Data({
    required this.id,
    required this.nomorKartu,
    required this.passcode,
    required this.createdAt,
    required this.updatedAt,
    required this.santri,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      nomorKartu: json['nomorKartu'] ?? json['nomor_kartu'],
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toString(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toString(),
      ),
      santri: Santri.fromJson(json['santri']),
      passcode: json['passcode'] ?? '',
    );
  }
}

Santri santrifromJson(String str) => Santri.fromJson(json.decode(str));

class Santri {
  int id;
  String name;
  String kelas;
  String nisn;
  int? saldo;
  int? hutang;
  String jurusan;
  Parent? parent;
  DateTime createdAt;
  DateTime updatedAt;

  Santri({
    required this.id,
    required this.name,
    required this.kelas,
    required this.nisn,
    this.saldo,
    this.hutang,
    required this.jurusan,
    this.parent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Santri.fromJson(Map<String, dynamic> json) {
    return Santri(
      id: json['id'],
      name: json['name'] ?? '',
      kelas: json['kelas'] ?? '',
      saldo: json['saldo'] != null ? json['saldo'] as int : 0, // kasih fallback
      hutang: json['hutang'] != null ? json['hutang'] as int : 0,
      jurusan: json['jurusan'] ?? '',
      parent: json['parent'] != null ? Parent.fromJson(json['parent']) : null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      nisn: json['nisn'] ?? '',
    );
  }
}

class Parent {
  int id;

  Parent({required this.id});

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(id: json['id']);
  }
}
