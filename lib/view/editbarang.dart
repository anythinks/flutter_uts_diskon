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
  final _diskonController = TextEditingController();

  bool _validateNama = false;
  bool _validateSatuan = false;
  bool _validateHargaBeli = false;
  bool _validateHargaJual = false;
  bool _validateDiskon = false;

  final _barangService = BarangService();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.barang.nama ?? '';
    _satuanController.text = widget.barang.satuan ?? '';
    _hargabeliController.text = widget.barang.hargabeli?.toString() ?? '';
    _hargajualController.text = widget.barang.hargajual?.toString() ?? '';
    _diskonController.text = widget.barang.diskon?.toString() ?? '';
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
                  errorText: _validateHargaBeli
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
                  errorText: _validateHargaJual
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
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    child: const Text('Update'),
                    onPressed: () async {
                      setState(() {
                        _validateNama = _namaController.text.isEmpty;
                        _validateSatuan = _satuanController.text.isEmpty;
                        _validateHargaBeli = _hargabeliController.text.isEmpty;
                        _validateHargaJual = _hargajualController.text.isEmpty;
                        _validateDiskon = _diskonController.text.isEmpty;
                      });

                      if (!_validateNama &&
                          !_validateSatuan &&
                          !_validateHargaBeli &&
                          !_validateHargaJual &&
                          !_validateDiskon) {
                        var barang = Barang()
                          ..kode = widget.barang.kode
                          ..nama = _namaController.text
                          ..satuan = _satuanController.text
                          ..hargabeli = int.parse(_hargabeliController.text)
                          ..hargajual = int.parse(_hargajualController.text)
                          ..diskon = _diskonController.text;

                        var hasil = await _barangService.updateBarang(barang);
                        Navigator.pop(context, hasil);
                      }
                    },
                  ),
                  const SizedBox(width: 10.0),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    child: const Text(
                      'Reset',
                    ),
                    onPressed: () {
                      setState(() {
                        _namaController.clear();
                        _satuanController.clear();
                        _hargabeliController.clear();
                        _hargajualController.clear();
                        _diskonController.clear();
                        _validateNama = false;
                        _validateSatuan = false;
                        _validateHargaBeli = false;
                        _validateHargaJual = false;
                        _validateDiskon = false;
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
