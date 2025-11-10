import 'dart:convert';

List<Spp> sppFromJson(String str) =>
    List<Spp>.from(json.decode(str).map((x) => Spp.fromJson(x)));

class Spp {
  String id;
  String studentId;
  String typeId;
  String status;
  String amount;
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
        amount: json["amount"],
        dueDate: DateTime.parse(json["dueDate"]),
        month: json["month"],
        semester: json["semester"],
        ta: json["TA"],
        monthsInArrears: json["monthsInArrears"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        student: Student.fromJson(json["student"]),
        type: Type.fromJson(json["type"]),
      );

  operator [](String other) {}
}

class Student {
  String id;
  String name;
  String nisn;

  Student({
    required this.id,
    required this.name,
    required this.nisn,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        nisn: json["NISN"],
      );
}

class Type {
  String id;
  String name;
  int nominal;
  String type;

  Type({
    required this.id,
    required this.name,
    required this.nominal,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
        nominal: json["nominal"],
        type: json["type"],
      );
}
