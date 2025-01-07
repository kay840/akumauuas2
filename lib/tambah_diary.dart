import 'package:akumauuas/halaman_diary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahDiary extends StatefulWidget {
  const TambahDiary({super.key});

  @override
  State<TambahDiary> createState() => _TambahDiaryState();
}

class _TambahDiaryState extends State<TambahDiary> {

  final formKey = GlobalKey<FormState>();
  TextEditingController id_produk = TextEditingController();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  Future _simpan () async {
    final respon = 
      await http.post(Uri.parse('http://localhost/api_produk/create.php'),
      body: {
        'id_produk': id_produk.text,
        'nama_produk': nama_produk.text,
        'harga_produk' : harga_produk.text,
      });
      if (respon.statusCode == 200) {
        return true;
      }
      return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Diary'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama_produk,
                decoration: InputDecoration(hintText: 'Judul Diary', border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if (value!.isEmpty){
                    return "Hai Best, Judul Diary Tidak Boleh Kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: harga_produk,
                decoration: InputDecoration(hintText: 'Deskripsi Diary', border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if (value!.isEmpty){
                    return "Hai Best, Deskripsi Diary Tidak Boleh Kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                onPressed: () {
                if (formKey.currentState!.validate()){
                  _simpan().then((value) {
                    if (value){
                      final snackBar = SnackBar(content: const Text ('Diary Berhasil Disimpan'),);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else{
                      final snackBar = SnackBar(content: const Text ('Diary Gagal Disimpan'),);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context)=> HalamanDiary())),
                  (route) => false);
                }
              }, child: Text('Simpan'))
            ],
          ),
        )),
    );
  }
}