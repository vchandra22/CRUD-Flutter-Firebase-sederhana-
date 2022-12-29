import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi_uas/models/inventory.dart';

class FirestoreService {
  static Future<void> addInventory(Inventory inventory) async {
    await FirebaseFirestore.instance.collection('data_mahasiswa').add(inventory.toJson());
  }

  static Future<void> hapusData(String id) async {
    await FirebaseFirestore.instance.collection('data_mahasiswa').doc(id).delete();
  }

  static Future<void> editData(Inventory inventory, String id) async {
    await FirebaseFirestore.instance.collection('data_mahasiswa').doc(id).update(inventory.toJson());
  }
}