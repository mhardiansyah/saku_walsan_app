class SantriSummary {
  final int saldo;
  final int jumlahTransaksi;
  final int hutang;

  SantriSummary({
    required this.saldo,
    required this.jumlahTransaksi,
    required this.hutang,
  });

  factory SantriSummary.fromJson(Map<String, dynamic> json) {
    return SantriSummary(
      saldo: json['saldo'] ?? 0,
      jumlahTransaksi: json['jumlahTransaksi'] ?? 0,
      hutang: json['hutang'] ?? 0,
    );
  }
}
