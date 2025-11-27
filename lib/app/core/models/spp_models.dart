class Spp {
  String status;
  String msg;
  SppData data;

  Spp({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory Spp.fromJson(Map<String, dynamic> json) => Spp(
        status: json["status"],
        msg: json["msg"],
        data: SppData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class SppData {
  bool success;
  Message message;
  int code;
  String status;
  DateTime timestamp;
  String locale;
  DataData data;
  List<dynamic> included;
  int totalData;
  Meta meta;
  dynamic pagination;
  dynamic errors;
  Links links;
  Links others;

  SppData({
    required this.success,
    required this.message,
    required this.code,
    required this.status,
    required this.timestamp,
    required this.locale,
    required this.data,
    required this.included,
    required this.totalData,
    required this.meta,
    required this.pagination,
    required this.errors,
    required this.links,
    required this.others,
  });

  factory SppData.fromJson(Map<String, dynamic> json) => SppData(
        success: json["success"],
        message: Message.fromJson(json["message"]),
        code: json["code"],
        status: json["status"],
        timestamp: DateTime.parse(json["timestamp"]),
        locale: json["locale"],
        data: DataData.fromJson(json["data"]),
        included: json["included"] ?? [],
        totalData: json["total_data"],
        meta: Meta.fromJson(json["meta"]),
        pagination: json["pagination"],
        errors: json["errors"],
        links: Links(),
        others: Links(),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message.toJson(),
        "code": code,
        "status": status,
        "timestamp": timestamp.toIso8601String(),
        "locale": locale,
        "data": data.toJson(),
        "included": included,
        "total_data": totalData,
        "meta": meta.toJson(),
        "pagination": pagination,
        "errors": errors,
        "links": {},
        "others": {},
      };
}

class DataData {
  List<OltherPayment> oltherPayments;
  List<SppPayment> sppPayment;
  History history;

  DataData({
    required this.oltherPayments,
    required this.sppPayment,
    required this.history,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        oltherPayments: (json["oltherPayments"] as List)
            .map((x) => OltherPayment.fromJson(x))
            .toList(),
        sppPayment: (json["sppPayment"] as List)
            .map((x) => SppPayment.fromJson(x))
            .toList(),
        history: History.fromJson(json["history"]),
      );

  Map<String, dynamic> toJson() => {
        "oltherPayments": oltherPayments.map((x) => x.toJson()).toList(),
        "sppPayment": sppPayment.map((x) => x.toJson()).toList(),
        "history": history.toJson(),
      };
}

class History {
  List<dynamic> spp;
  List<dynamic> olther;

  History({
    required this.spp,
    required this.olther,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        spp: json["spp"] ?? [],
        olther: json["olther"] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "spp": spp,
        "olther": olther,
      };
}

class OltherPayment {
  String id;
  String studentId;
  DateTime date;
  String status;
  int amount;
  String method;
  dynamic month;
  dynamic year;
  DateTime createdAt;
  int remainder;
  int paid;
  Type type;

  OltherPayment({
    required this.id,
    required this.studentId,
    required this.date,
    required this.status,
    required this.amount,
    required this.method,
    required this.month,
    required this.year,
    required this.createdAt,
    required this.remainder,
    required this.paid,
    required this.type,
  });

  factory OltherPayment.fromJson(Map<String, dynamic> json) => OltherPayment(
        id: json["id"],
        studentId: json["studentId"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        amount: json["amount"],
        method: json["method"],
        month: json["month"],
        year: json["year"],
        createdAt: DateTime.parse(json["createdAt"]),
        remainder: json["remainder"],
        paid: json["paid"],
        type: Type.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "date": date.toIso8601String(),
        "status": status,
        "amount": amount,
        "method": method,
        "month": month,
        "year": year,
        "createdAt": createdAt.toIso8601String(),
        "remainder": remainder,
        "paid": paid,
        "type": type.toJson(),
      };
}

class Type {
  String id;
  String name;
  int semester;
  int nominal;
  String status;
  String ta;
  String type;

  Type({
    required this.id,
    required this.name,
    required this.semester,
    required this.nominal,
    required this.status,
    required this.ta,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
        semester: json["semester"],
        nominal: json["nominal"],
        status: json["status"],
        ta: json["TA"], // JSON pakai TA huruf besar
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "semester": semester,
        "nominal": nominal,
        "status": status,
        "TA": ta,
        "type": type,
      };
}

class SppPayment {
  String id;
  String studentId;
  String month;
  String year;
  int nominal;
  Status status;
  dynamic paidAt;
  DateTime createdAt;
  int remainder;
  int paid;

  SppPayment({
    required this.id,
    required this.studentId,
    required this.month,
    required this.year,
    required this.nominal,
    required this.status,
    required this.paidAt,
    required this.createdAt,
    required this.remainder,
    required this.paid,
  });

  factory SppPayment.fromJson(Map<String, dynamic> json) => SppPayment(
        id: json["id"],
        studentId: json["studentId"],
        month: json["month"],
        year: json["year"],
        nominal: json["nominal"],
        status: Status.values.firstWhere(
          (e) => e.toString().split(".").last == json["status"],
        ),
        paidAt: json["paidAt"],
        createdAt: DateTime.parse(json["createdAt"]),
        remainder: json["remainder"],
        paid: json["paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "month": month,
        "year": year,
        "nominal": nominal,
        "status": status.toString().split(".").last,
        "paidAt": paidAt,
        "createdAt": createdAt.toIso8601String(),
        "remainder": remainder,
        "paid": paid,
      };
}

enum Status { BELUM_LUNAS }

class Links {
  Links();

  factory Links.fromJson(Map<String, dynamic> json) => Links();

  Map<String, dynamic> toJson() => {};
}

class Message {
  String en;
  String id;

  Message({
    required this.en,
    required this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        en: json["en"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}

class Meta {
  String requestId;
  String traceId;
  int executionTimeMs;
  String apiVersion;
  String environment;
  dynamic auth;
  dynamic debug;

  Meta({
    required this.requestId,
    required this.traceId,
    required this.executionTimeMs,
    required this.apiVersion,
    required this.environment,
    required this.auth,
    required this.debug,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        requestId: json["request_id"],
        traceId: json["trace_id"],
        executionTimeMs: json["execution_time_ms"],
        apiVersion: json["api_version"],
        environment: json["environment"],
        auth: json["auth"],
        debug: json["debug"],
      );

  Map<String, dynamic> toJson() => {
        "request_id": requestId,
        "trace_id": traceId,
        "execution_time_ms": executionTimeMs,
        "api_version": apiVersion,
        "environment": environment,
        "auth": auth,
        "debug": debug,
      };
}
