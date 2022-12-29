import 'package:aplikasi_uas/models/inventory.dart';
import 'package:aplikasi_uas/providers/firestore_service.dart';
import 'package:aplikasi_uas/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DataMahasiswa extends StatefulWidget {
  DataMahasiswa({super.key, this.inventory, this.id});

  final Inventory? inventory;
  final String? id;

  @override
  State<DataMahasiswa> createState() => _DataMahasiswaState();
}

class _DataMahasiswaState extends State<DataMahasiswa> {
  late TextEditingController nameController;
  late TextEditingController prodiController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    prodiController = TextEditingController();
    
    if (widget.inventory != null) {
      nameController.text = widget.inventory!.nama;
      prodiController.text = widget.inventory!.prodi;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    prodiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
        actions: [
          IconButton(
            onPressed: () async {
              if (widget.inventory != null) {
                await FirestoreService.editData(Inventory(nama: nameController.text, 
                prodi: prodiController.text), 
                widget.id!,
                );
              } else {
              await FirestoreService.addInventory(Inventory(
                nama: nameController.text, 
                prodi: prodiController.text)
              );
            }

            Navigator.pop(context);
          }, icon: Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Masukkan Nama Mahasiswa',
                label: Text('Nama Mahasiswa'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: prodiController,
              decoration: InputDecoration(
                hintText: 'Masukkan Prodi Mahasiswa',
                label: Text('Prodi Mahasiswa'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}