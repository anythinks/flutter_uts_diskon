class Barang {
  String? kode;
  String? nama;
  String? satuan;
  int? hargabeli;
  int? hargajual;
  String? diskon;
  String? golongan;
  String? warna;
  int? berat;

  barangMap() {
    var mapping = <String, dynamic>{};
    mapping['kode'] = kode;
    mapping['nama'] = nama;
    mapping['satuan'] = satuan;
    mapping['hargabeli'] = hargabeli;
    mapping['hargajual'] = hargajual;
    mapping['diskon'] = diskon;
    mapping['golongan'] = golongan;
    mapping['warna'] = warna;
    mapping['berat'] = berat;
    return mapping;
  }
}
