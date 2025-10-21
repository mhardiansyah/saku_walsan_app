import 'dart:convert';

import 'package:saku_walsan_app/app/core/models/items_models.dart';


HistoryResponse historyResponseFromJson(String str) =>
    HistoryResponse.fromJson(json.decode(str));

class HistoryResponse {
  String status;
  String msg;
  DataHistory? data;

  HistoryResponse({required this.status, required this.msg, this.data});

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      status: json['status'] ?? '',
      msg: json['msg'] ?? '',
      data: json['data'] != null ? DataHistory.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class DataHistory {
  int id;
  int santriId;
  int totalAmount;
  String status;
  Santri santri;
  List<Item> items;
  DateTime createdAt;

  DataHistory({
    required this.id,
    required this.santriId,
    required this.totalAmount,
    required this.status,
    required this.santri,
    required this.items,
    required this.createdAt,
  });

  factory DataHistory.fromJson(Map<String, dynamic> json) {
    return DataHistory(
      id: json['id'] ?? 0,
      santriId: json['santriId'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      status: json['status'] ?? '',
      santri: Santri.fromJson(json['santri'] ?? {}),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e))
              .toList() ??
          [],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "santriId": santriId,
    "totalAmount": totalAmount,
    "status": status,
    "santri": santri.toJson(),
    "items": items.map((e) => e.toJson()).toList(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class Item {
  int id;
  int historyId;
  int itemId;
  int quantity;
  int priceAtPurchase;
  Items? item;

  Item({
    required this.id,
    required this.historyId,
    required this.itemId,
    required this.quantity,
    required this.priceAtPurchase,
    this.item,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? 0,
      historyId: json['historyId'] ?? 0,
      itemId: json['itemId'] ?? 0,
      quantity: json['quantity'] ?? 0,
      priceAtPurchase: json['priceAtPurchase'] ?? 0,
      item: json['items'] != null ? Items.fromJson(json['items']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "historyId": historyId,
    "itemId": itemId,
    "quantity": quantity,
    "priceAtPurchase": priceAtPurchase,
  };
}

class Santri {
  int id;
  String name;
  String kelas;
  int saldo;
  int hutang;
  String jurusan;
  DateTime createdAt;
  DateTime updatedAt;

  Santri({
    required this.id,
    required this.name,
    required this.kelas,
    required this.saldo,
    required this.hutang,
    required this.jurusan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Santri.fromJson(Map<String, dynamic> json) {
    return Santri(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      kelas: json['kelas'] ?? '',
      saldo: json['saldo'] ?? 0,
      hutang: json['hutang'] ?? 0,
      jurusan: json['jurusan'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "kelas": kelas,
    "saldo": saldo,
    "hutang": hutang,
    "jurusan": jurusan,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
