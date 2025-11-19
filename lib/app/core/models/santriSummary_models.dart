class SantriSummary {
  int? saldo;
  int? hutang;
  int? totalTransaksi;

  SantriSummary({this.saldo, this.hutang, this.totalTransaksi});

  factory SantriSummary.fromJson(Map<String, dynamic> json) {
    return SantriSummary(
      saldo: json['saldo'],
      hutang: json['hutang'],
      totalTransaksi: json['totalTransaksi'],
    );
  }
}
