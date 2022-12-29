import 'package:aplikasi_uas/models/inventory.dart';
import 'package:aplikasi_uas/providers/firestore_service.dart';
import 'package:aplikasi_uas/views/data_mhs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_uas/views/popular_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Halo, ' + user.email!,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.logout, size: 28)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DataMahasiswa();
                },
              ));
          },
          child: Icon(Icons.add),
        ),

        body: 
        SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(153, 228, 228, 228),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Row(children: [
                  const Icon(
                    Icons.search,
                    size: 20,
                  ),
                  Container(
                    width: 300,
                    margin: const EdgeInsets.only(left: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Cari",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ]),
              ),
              const SizedBox(height: 10),
              PopularWidget(),
              const SizedBox(height: 20),
              Text(
                "Data Mahasiswa",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: 
                  FirebaseFirestore.instance.collection('data_mahasiswa').snapshots(),
                  builder:(context, snapshot) {
                    if (snapshot.hasData) {
                      var data_mahasiswa = snapshot.data!.docs
                          .map((inventory) => Inventory.fromSnapshot(inventory))
                          .toList();

                      return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data_mahasiswa.length,
                      itemBuilder: (context, index) {
                        var id = snapshot.data!.docs[index].id;

                        return ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DataMahasiswa(
                                  inventory: data_mahasiswa[index],
                                  id: id,
                                );
                              },
                            ));
                          },
                          title: Text(data_mahasiswa[index].nama),
                          subtitle: Text(data_mahasiswa[index].prodi),
                          trailing: IconButton(onPressed: (){
                            FirestoreService.hapusData(id);
                          },
                          icon: Icon(
                            Icons.delete, 
                            color: Colors.red,
                          )),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}