import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory {
  String nama;
  String prodi;

  Inventory({
    required this.nama,
    required this.prodi,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'prodi': prodi,
    };
  }

  // Mengembalikan function berupa objek 
  factory Inventory.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Inventory(nama: json['nama'], prodi: json['prodi']);
  }
}

