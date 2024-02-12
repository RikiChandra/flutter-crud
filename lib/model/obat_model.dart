class ObatModel {
  int code;
  String message;
  List<Obat> data;

  ObatModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ObatModel.fromJson(Map<String, dynamic> json) => ObatModel(
        code: json['code'],
        message: json['message'],
        data: List<Obat>.from(json['data'].map((x) => Obat.fromJson(x))),
      );
}

class Obat {
  int id;
  String nama;
  int harga;
  String satuan;
  DateTime createdAt;
  DateTime updatedAt;

  Obat({
    required this.id,
    required this.nama,
    required this.harga,
    required this.satuan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        satuan: json['satuan'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
}
