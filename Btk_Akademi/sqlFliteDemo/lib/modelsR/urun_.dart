class Urun {
  int? id;
  String? ad;
  String? aciklama;
  double? fiyat;

  Urun({this.ad, this.aciklama, this.fiyat});
  Urun.idLi({this.id, this.ad, this.aciklama, this.fiyat});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["ad"] = ad;
    map["aciklama"] = aciklama;
    map["fiyat"] = fiyat;
    map["id"] = id;
    return map;
  }

  /*Urun.fromObject(dynamic o) {
    int id = int.tryParse(o["id"]);
    ad = o.ad;
    aciklama = o.aciklama;
    fiyat = o.fiyat;
  }*/
}
