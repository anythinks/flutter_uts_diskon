class Barang {
  String? kode;
  String? nama;
  String? satuan;
  int? hargabeli;
  int? hargajual;
  barangMap() {
    var mapping = <String, dynamic>{};
    mapping['kode'] = kode;
    mapping['nama'] = nama!;
    mapping['satuan'] = satuan!;
    mapping['hargabeli'] = hargabeli!;
    mapping['hargajual'] = hargajual!;
    return mapping;
  }
}
