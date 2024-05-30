import 'package:flutter/material.dart';
import 'package:myapp/controller/barangservice.dart';
import 'package:myapp/model/barang.dart';
import 'package:myapp/util/util.dart';

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
  final _golonganController = TextEditingController();
  final _warnaController = TextEditingController();
  final _beratController = TextEditingController();

  bool _validateKode = false;
  bool _validateNama = false;
  bool _validateSatuan = false;
  bool _validateHargaBeli = false;
  bool _validateHargaJual = false;
  bool _validateDiskon = false;
  bool _validateGolongan = false;
  bool _validateWarna = false;
  bool _validateBerat = false;

  void clear() {
    _kodeController.clear();
    _namaController.clear();
    _satuanController.clear();
    _hargabeliController.clear();
    _hargajualController.clear();
    _diskonController.clear();
    _golonganController.clear();
    _warnaController.clear();
    _beratController.clear();
    _validateKode = false;
    _validateNama = false;
    _validateSatuan = false;
    _validateHargaBeli = false;
    _validateHargaJual = false;
    _validateDiskon = false;
    _validateGolongan = false;
    _validateWarna = false;
    _validateBerat = false;
  }

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
              formBarang(_kodeController, 'Kode', 'Enter Kode',
                  _validateKode ? 'Kode Value Can\'t Be Empty' : null),
              const SizedBox(height: 20.0),
              formBarang(_namaController, 'Nama', 'Enter Nama',
                  _validateNama ? 'Nama Value Can\'t Be Empty' : null),
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
                  )),
              const SizedBox(height: 20.0),
              formBarang(_golonganController, 'Golongan', 'Enter Golongan',
                  _validateKode ? 'Golongan Value Can\'t Be Empty' : null),
              const SizedBox(height: 20.0),
              formBarang(_warnaController, 'Warna', 'Enter Warna',
                  _validateKode ? 'Warna Value Can\'t Be Empty' : null),
              const SizedBox(height: 20.0),
              formBarang(_beratController, 'Berat (Kg)', 'Enter Berat (Kg)',
                  _validateKode ? 'Berat Value Can\'t Be Empty' : null,
                  keyboardType: TextInputType.number),
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
                        _validateHargaBeli = _hargabeliController.text.isEmpty;
                        _validateHargaJual = _hargajualController.text.isEmpty;
                        _validateDiskon = _diskonController.text.isEmpty;
                        _validateGolongan = _golonganController.text.isEmpty;
                        _validateWarna = _warnaController.text.isEmpty;
                        _validateBerat = _beratController.text.isEmpty;
                      });

                      if (!_validateKode &&
                          !_validateNama &&
                          !_validateSatuan &&
                          !_validateHargaBeli &&
                          !_validateHargaJual &&
                          !_validateDiskon &&
                          !_validateGolongan &&
                          !_validateWarna &&
                          !_validateBerat) {
                        var barang = Barang()
                          ..kode = _kodeController.text
                          ..nama = _namaController.text
                          ..satuan = _satuanController.text
                          ..hargabeli = int.parse(_hargabeliController.text)
                          ..hargajual = int.parse(_hargajualController.text)
                          ..diskon = _diskonController.text
                          ..golongan = _golonganController.text
                          ..warna = _warnaController.text
                          ..berat = int.parse(_beratController.text);

                        var hasil = await _barangService.saveBarang(barang);
                        // ignore: use_build_context_synchronously
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
                        clear();
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
