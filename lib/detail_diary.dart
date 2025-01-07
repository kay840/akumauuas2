import 'package:flutter/material.dart';

class DetailDiary extends StatefulWidget {
  final Map ListData;
  DetailDiary({Key? key, required this.ListData}) : super (key: key);
  //const DetailDiary({super.key});

  @override
  State<DetailDiary> createState() => _DetailDiaryState();
}

class _DetailDiaryState extends State<DetailDiary> {

  final formKey = GlobalKey<FormState>();
  TextEditingController id_produk = TextEditingController();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  @override
  Widget build(BuildContext context) {
    id_produk.text = widget.ListData['id_produk'];
    nama_produk.text = widget.ListData['nama_produk'];
    harga_produk.text = widget.ListData['harga_produk'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Diary'),
        backgroundColor: const Color.fromARGB(255, 221, 168, 230),
      ),

      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Judul Diary'),
                  subtitle: Text(widget.ListData['nama_produk']),
                ),
                ListTile(
                  title: Text('Deskripsi Diary'),
                  subtitle: Text(widget.ListData['harga_produk']),
                ),
              ],
            ),
          ),
        ),),
    );
  }
}