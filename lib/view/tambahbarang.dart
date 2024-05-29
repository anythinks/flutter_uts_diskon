import 'package:flutter/material.dart';
import 'package:myapp/controller/barangservice.dart';
import 'package:myapp/model/barang.dart';

class TambahBarang extends StatefulWidget {
  const TambahBarang({super.key});

  @override
  State<TambahBarang> createState() => _TambahBarangState();
}

class _TambahBarangState extends State<TambahBarang> {
  final _kodeController = TextEditingController();
  final _namaController = TextEditingController();
  final _satuanController = TextEditingController();
  final _hargabeliController = TextEditingController();
  final _hargajualController = TextEditingController();
  final _diskonController = TextEditingController();

  bool _validateKode = false;
  bool _validateNama = false;
  bool _validateSatuan = false;
  bool _validatehargabeli = false;
  bool _validatehargajual = false;
  bool _validateDiskon = false;

  final _barangService = BarangService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Tambah Barang'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              TextField(
                controller: _kodeController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Kode',
                  labelText: 'Kode',
                  errorText:
                      _validateKode ? 'Kode Value Can\'t Be Empty' : null,
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
              TextField(
                  controller: _diskonController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Diskon',
                    labelText: 'Diskon',
                    errorText:
                        _validateDiskon ? 'Diskon Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    child: const Text('Save'),
                    onPressed: () async {
                      setState(() {
                        _validateKode = _kodeController.text.isEmpty;
                        _validateNama = _namaController.text.isEmpty;
                        _validateSatuan = _satuanController.text.isEmpty;
                        _validatehargabeli = _hargabeliController.text.isEmpty;
                        _validatehargajual = _hargajualController.text.isEmpty;
                        _validateDiskon = _diskonController.text.isEmpty;
                      });

                      if (!_validateKode &&
                          !_validateNama &&
                          !_validateSatuan &&
                          !_validatehargabeli &&
                          !_validatehargajual &&
                          !_validateDiskon) {
                        var barang = Barang()
                          ..kode = _kodeController.text
                          ..nama = _namaController.text
                          ..satuan = _satuanController.text
                          ..hargabeli = int.parse(_hargabeliController.text)
                          ..hargajual = int.parse(_hargajualController.text)
                          ..diskon = _diskonController.text;

                        var hasil = await _barangService.saveBarang(barang);
                        Navigator.pop(context, hasil);
                      }
                    },
                  ),
                  const SizedBox(width: 10.0),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      setState(() {
                        _kodeController.clear();
                        _namaController.clear();
                        _satuanController.clear();
                        _hargabeliController.clear();
                        _hargajualController.clear();
                        _diskonController.clear();
                        _validateKode = false;
                        _validateNama = false;
                        _validateSatuan = false;
                        _validatehargabeli = false;
                        _validatehargajual = false;
                        _validateDiskon = false;
                      });
                    },
                    child: const Text('Reset'),
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
