import 'dart:convert';

List<Spp> sppFromJson(String str) =>
    List<Spp>.from(json.decode(str).map((x) => Spp.fromJson(x)));

class Spp {
  String id;
  String studentId;
  String typeId;
  String status;
  double amount;
  DateTime dueDate;
  int month;
  int semester;
  String ta;
  int monthsInArrears;
  DateTime createdAt;
  DateTime updatedAt;
  Student student;
  Type type;

  Spp({
    required this.id,
    required this.studentId,
    required this.typeId,
    required this.status,
    required this.amount,
    required this.dueDate,
    required this.month,
    required this.semester,
    required this.ta,
    required this.monthsInArrears,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
    required this.type,
  });

  factory Spp.fromJson(Map<String, dynamic> json) => Spp(
    id: json["id"],
    studentId: json["studentId"],
    typeId: json["typeId"],
    status: json["status"],
    amount: double.tryParse(json["amount"].toString()) ?? 0.0,
    dueDate: DateTime.parse(json["dueDate"]),
    month: json["month"] ?? 0,
    semester: json["semester"] ?? 0,
    ta: json["TA"] ?? '',
    monthsInArrears: json["monthsInArrears"] ?? 0,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    student: Student.fromJson(json["student"]),
    type: Type.fromJson(json["type"]),
  );

  @override
  String toString() =>
      'Spp(id: $id, status: $status, amount: $amount, name: ${student.name})';
}

class Student {
  String id;
  String name;
  String nisn;
  String? inductNumber;
  String? dorm;
  int? generation;
  String? status;
  String? major;
  bool? isDelete;
  String? tipeProgram;
  DateTime? createdAt;
  DateTime? updatedAt;

  Student({
    required this.id,
    required this.name,
    required this.nisn,
    this.inductNumber,
    this.dorm,
    this.generation,
    this.status,
    this.major,
    this.isDelete,
    this.tipeProgram,
    this.createdAt,
    this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    nisn: json["NISN"],
    inductNumber: json["InductNumber"],
    dorm: json["dorm"],
    generation: json["generation"],
    status: json["status"],
    major: json["major"],
    isDelete: json["isDelete"],
    tipeProgram: json["tipeProgram"],
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null,
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : null,
  );
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
    semester: json["semester"] ?? 0,
    nominal: (json["nominal"] as num?)?.toInt() ?? 0,
    status: json["status"] ?? '',
    ta: json["TA"] ?? '',
    type: json["type"] ?? '',
  );
}
