import 'dart:convert';

import 'package:saku_walsan_app/app/core/models/items_models.dart';
import 'package:saku_walsan_app/app/core/models/santri_models.dart';



History historyFromJson(String str) => History.fromJson(json.decode(str));

class History {
  String status;
  String msg;
  List<HistoryDetail> historyDetail;

  History({
    required this.status,
    required this.msg,
    required this.historyDetail,
  });
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      status: json['status'] ?? '',
      msg: json['msg'] ?? '',
      historyDetail:
          (json['data'] as List<dynamic>?)
              ?.map((e) => HistoryDetail.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class HistoryDetail {
  int id;
  int santriId;
  int totalAmount;
  String status;
  Santri santri;
  List<DataItems> dataitems;
  DateTime createdAt;

  HistoryDetail({
    required this.id,
    required this.santriId,
    required this.totalAmount,
    required this.status,
    required this.santri,
    required this.dataitems,
    required this.createdAt,
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json) {
    return HistoryDetail(
      id: json['id'] ?? 0,
      santriId: json['santriId'] ?? 0, // ganti santri_id -> santriId
      totalAmount:
          json['totalAmount'] ?? 0, // ganti total_amount -> totalAmount
      status: json['status'] ?? '',
      santri: Santri.fromJson(json['santri'] ?? {}),
      dataitems:
          (json['items'] as List<dynamic>?)
              ?.map((e) => DataItems.fromJson(e))
              .toList() ??
          [],
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.now(), 
    );
  }


}

class DataItems {
  int id;
  int historyId;
  int itemId;
  Items item;
  int quantity;
  int priceAtPurchase;

  DataItems({
    required this.id,
    required this.historyId,
    required this.itemId,
    required this.item,
    required this.quantity,
    required this.priceAtPurchase,
  });
  factory DataItems.fromJson(Map<String, dynamic> json) {
    return DataItems(
      id: json['id'] ?? 0,
      historyId: json['historyId'] ?? 0, // ganti history_id -> historyId
      itemId: json['itemId'] ?? 0, // ganti item_id -> itemId
      item: Items.fromJson(json['item'] ?? {}),
      quantity: json['quantity'] ?? 0,
      priceAtPurchase:
          json['priceAtPurchase'] ??
          0, // ganti price_at_purchase -> priceAtPurchase
    );
  }
}
