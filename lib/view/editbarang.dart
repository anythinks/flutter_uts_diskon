import 'package:flutter/material.dart';

import '../controller/barangservice.dart';
import '../model/barang.dart';

class EditBarang extends StatefulWidget {
  final Barang barang;

  const EditBarang({super.key, required this.barang});

  @override
  State<EditBarang> createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  final _namaController = TextEditingController();
  final _satuanController = TextEditingController();
  final _hargabeliController = TextEditingController();
  final _hargajualController = TextEditingController();

  bool _validateNama = false;
  bool _validateSatuan = false;
  bool _validatehargabeli = false;
  bool _validatehargajual = false;

  final _barangService = BarangService();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.barang.nama ?? '';
    _satuanController.text = widget.barang.satuan ?? '';
    _hargabeliController.text = widget.barang.hargabeli?.toString() ?? '';
    _hargajualController.text = widget.barang.hargajual?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Edit Barang'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Barang',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Nama',
                  labelText: 'Nama',
                  errorText:
                      _validateNama ? 'Nama Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _satuanController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Satuan',
                  labelText: 'Satuan',
                  errorText:
                      _validateSatuan ? 'Satuan Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _hargabeliController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Harga Beli',
                  labelText: 'Harga Beli',
                  errorText: _validatehargabeli
                      ? 'Harga Beli Value Can\'t Be Empty'
                      : null,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _hargajualController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Harga Jual',
                  labelText: 'Harga Jual',
                  errorText: _validatehargajual
                      ? 'Harga Jual Value Can\'t Be Empty'
                      : null,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    child: const Text('Update'),
                    onPressed: () async {
                      setState(() {
                        _validateNama = _namaController.text.isEmpty;
                        _validateSatuan = _satuanController.text.isEmpty;
                        _validatehargabeli = _hargabeliController.text.isEmpty;
                        _validatehargajual = _hargajualController.text.isEmpty;
                      });

                      if (!_validateNama &&
                          !_validateSatuan &&
                          !_validatehargabeli &&
                          !_validatehargajual) {
                        var barang = Barang()
                          ..kode = widget.barang.kode
                          ..nama = _namaController.text
                          ..satuan = _satuanController.text
                          ..hargabeli = int.parse(_hargabeliController.text)
                          ..hargajual = int.parse(_hargajualController.text);

                        var hasil = await _barangService.updateBarang(barang);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, hasil);
                      }
                    },
                  ),
                  const SizedBox(width: 10.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    child: const Text('Reset'),
                    onPressed: () {
                      setState(() {
                        _namaController.clear();
                        _satuanController.clear();
                        _hargabeliController.clear();
                        _hargajualController.clear();
                        _validateNama = false;
                        _validateSatuan = false;
                        _validatehargabeli = false;
                        _validatehargajual = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
