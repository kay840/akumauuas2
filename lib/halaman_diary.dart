import 'dart:convert';

import 'package:akumauuas/detail_diary.dart';
import 'package:akumauuas/edit_diary.dart';
import 'package:akumauuas/tambah_diary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanDiary extends StatefulWidget {
  const HalamanDiary({super.key});

  @override
  State<HalamanDiary> createState() => _HalamanDiaryState();
}

class _HalamanDiaryState extends State<HalamanDiary> {
  List _listdata= [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon = 
      await http.get(Uri.parse('http://localhost/api_produk/read.php'));
    if (respon.statusCode == 200){
      final data = jsonDecode(respon.body);
      setState(() {
        _listdata = data;
        _loading = false;
      });
      } 
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final respon = 
      await http.post(Uri.parse('http://localhost/api_produk/delete.php'), body: {
        "id_produk": id,
      });
    if (respon.statusCode == 200){
      return true;
      } else{
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState(){
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Diary'),
        backgroundColor: const Color.fromARGB(255, 206, 163, 213),
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      )
      : ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: ((context, index) {
          return Card(
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailDiary(
                  ListData: { 
                    'id_produk': _listdata[index]
                          ['id_produk'],
                    'nama_produk': _listdata[index]
                          ['nama_produk'],
                    'harga_produk': _listdata[index]
                          ['harga_produk'],
                  },
                )));
              },
              child: ListTile(
                title: Text(_listdata[index]['nama_produk']),
                subtitle: Text(_listdata[index]['harga_produk']),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UbahDiary(
                        ListData: {
                        'id_produk': _listdata[index]
                              ['id_produk'],
                        'nama_produk': _listdata[index]
                              ['nama_produk'],
                        'harga_produk': _listdata[index]
                              ['harga_produk'],
                      },)));
                    }, 
                    icon: Icon(Icons.edit)),
                    IconButton(onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context, 
                      builder: (context){
                        return AlertDialog(
                          content: Text('Kamu Yakin Akan Menghapus Diary Ini?'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                _hapus(_listdata[index]['id_produk']).then((value){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> HalamanDiary())),
                                  (route) => false);
                                });
                              }, child: Text('Hapus')),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              }, child: Text('Batal')),
                          ],
                        );
                      });
                    }, icon: Icon(Icons.delete))
                  ],
                ),
              ),
            ),
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        child: Text('+', 
        style: TextStyle(fontSize: 24),),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TambahDiary()));
      }),

    );
  }
}