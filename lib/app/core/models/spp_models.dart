class Spp {
  final String status;
  final String msg;
  final Data data;

  Spp({required this.status, required this.msg, required this.data});

  factory Spp.fromJson(Map<String, dynamic> json) => Spp(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final bool success;
  final Message message;
  final int code;
  final String status;
  final DateTime timestamp;
  final String locale;
  final List<Datum> data;
  final List<dynamic> included;
  final int totalData;
  final Meta meta;
  final dynamic pagination;
  final dynamic errors;
  final Links links;
  final Links others;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"],
    message: Message.fromJson(json["message"]),
    code: json["code"],
    status: json["status"],
    timestamp: DateTime.parse(json["timestamp"]),
    locale: json["locale"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    included: json["included"],
    totalData: json["total_data"],
    meta: Meta.fromJson(json["meta"]),
    pagination: json["pagination"],
    errors: json["errors"],
    links: Links.fromJson(json["links"]),
    others: Links.fromJson(json["others"]),
  );
}

class Datum {
  final String id;
  final String namaPembayaran;
  final String kategori;
  final int nominal;
  final int remainder;
  final String status;
  final DateTime tanggalDibuat;

  Datum({
    required this.id,
    required this.namaPembayaran,
    required this.kategori,
    required this.nominal,
    required this.remainder,
    required this.status,
    required this.tanggalDibuat,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaPembayaran: json["namaPembayaran"],
    kategori: json["kategori"],
    nominal: json["nominal"],
    remainder: json["remainder"],
    status: json["status"],
    tanggalDibuat: DateTime.parse(json["tanggalDibuat"]),
  );
}

class Student {
  final String id;
  final String name;
  final String inductNumber;
  final String dorm;
  final int generation;
  final String status;
  final String major;
  final bool isDelete;
  final String nisn;
  final String tipeProgram;
  final DateTime createdAt;
  final DateTime updatedAt;

  Student({
    required this.id,
    required this.name,
    required this.inductNumber,
    required this.dorm,
    required this.generation,
    required this.status,
    required this.major,
    required this.isDelete,
    required this.nisn,
    required this.tipeProgram,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    inductNumber: json["InductNumber"],
    dorm: json["dorm"],
    generation: json["generation"],
    status: json["status"],
    major: json["major"],
    isDelete: json["isDelete"],
    nisn: json["NISN"],
    tipeProgram: json["tipeProgram"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
}

class Message {
  final String en;
  final String id;

  Message({required this.en, required this.id});

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(en: json["en"], id: json["id"]);
}

class Meta {
  final String requestId;
  final String traceId;
  final int executionTimeMs;
  final String apiVersion;
  final String environment;
  final dynamic auth;
  final dynamic debug;

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
}

class Links {
  Links();

  factory Links.fromJson(Map<String, dynamic> json) => Links();
}
