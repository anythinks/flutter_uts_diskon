import 'package:flutter/material.dart';
import 'package:myapp/model/barang.dart';
import 'package:myapp/util/util.dart';

class ViewBarang extends StatefulWidget {
  final Barang barang;
  const ViewBarang({super.key, required this.barang});

  @override
  State<ViewBarang> createState() => _ViewBarangState();
}

class _ViewBarangState extends State<ViewBarang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
        title: const Text('Detail Barang'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showData('Kode', widget.barang.kode!),
            const SizedBox(height: 20),
            showData('Nama', widget.barang.nama!),
            const SizedBox(height: 20),
            showData('Satuan', widget.barang.satuan!),
            const SizedBox(height: 20),
            showData('Harga Beli', widget.barang.hargabeli.toString()),
            const SizedBox(height: 20),
            showData('Harga Beli', widget.barang.hargajual.toString()),
            const SizedBox(height: 20),
            showData('Diskon', widget.barang.diskon!),
            const SizedBox(height: 20),
            showData('Golongan', widget.barang.golongan!),
            const SizedBox(height: 20),
            showData('Warna', widget.barang.warna!),
            const SizedBox(height: 20),
            showData('Berat', widget.barang.berat.toString())
          ],
        ),
      ),
    );
  }
}
