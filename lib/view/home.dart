import 'package:flutter/material.dart';
import 'package:myapp/controller/barangservice.dart';
import 'package:myapp/model/barang.dart';
import 'package:myapp/view/tambahbarang.dart';
import 'package:myapp/view/editbarang.dart';
import 'package:myapp/view/detailbarang.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _barangList = <Barang>[];
  final BarangService _barangService = BarangService();

  @override
  void initState() {
    super.initState();
    getAllBarang();
  }

  Future<void> getAllBarang() async {
    var barangs = await _barangService.readAllBarang();
    barangs.forEach((barang) {
      setState(() {
        var barangModel = Barang()
          ..kode = barang['kode']
          ..nama = barang['nama']
          ..satuan = barang['satuan']
          ..hargabeli = barang['hargabeli']
          ..hargajual = barang['hargajual']
          ..diskon = barang['diskon']
          ..golongan = barang['golongan']
          ..warna = barang['warna']
          ..berat = barang['berat'];
        _barangList.add(barangModel);
      });
    });
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _deleteFormDialog(BuildContext context, String kode) {
    showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text('Hapus'),
          content: const Text(
            'Yakin Ingin Menghapus?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () async {
                var result = await _barangService.deleteBarang(kode);
                if (result != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  getAllBarang();
                  _showSuccessSnackBar('Hapus Data Barang Success');
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Barang'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _barangList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewBarang(barang: _barangList[index]),
                    ),
                  ).then((data) {
                    if (data != null) {
                      getAllBarang();
                      _showSuccessSnackBar('Tambah Data Barang Success');
                    }
                  });
                },
                leading: const Icon(Icons.shopping_cart, color: Colors.purple),
                title: Text(_barangList[index].kode.toString()),
                subtitle: Text(_barangList[index].nama ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditBarang(barang: _barangList[index]),
                          ),
                        ).then((data) {
                          if (data != null) {
                            getAllBarang();
                            _showSuccessSnackBar('Data Barang Updated Success');
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.teal,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteFormDialog(
                            context, _barangList[index].kode ?? "");
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahBarang()),
          ).then((data) {
            if (data != null) {
              getAllBarang();
              _showSuccessSnackBar('Tambah Data Barang Success');
            }
          });
        },
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        label: const Text('Tambah'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
