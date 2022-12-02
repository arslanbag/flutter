import 'package:flutter/material.dart';
import 'package:sqlflitdemo/dataR/db_helper.dart';
import 'package:sqlflitdemo/modelsR/urun_.dart';

class UrunDetay extends StatefulWidget {
  Urun urun;
  UrunDetay(this.urun);

  @override
  State<StatefulWidget> createState() {
    return UrunDetayState(urun);
  }
}

enum secnekeler { sil, guncelle }

class UrunDetayState extends State {
  var txtAd = TextEditingController();
  var txtAciklama = TextEditingController();
  var txtFiyat = TextEditingController();
  Urun urun;
  UrunDetayState(this.urun);
  var dbHelper = DbHelper();

  @override
  void initState() {
    txtAd.text = urun.ad!;
    txtAciklama.text = urun.aciklama!;
    txtFiyat.text = urun.fiyat!.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün detayı ${urun.ad}"),
        actions: <Widget>[
          PopupMenuButton<secnekeler>(
            onSelected: secilenIslem,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<secnekeler>>[
              const PopupMenuItem<secnekeler>(
                value: secnekeler.sil,
                child: Text("Sil"),
              ),
              const PopupMenuItem<secnekeler>(
                value: secnekeler.guncelle,
                child: Text("Güncelle"),
              )
            ],
          )
        ],
      ),
      body: buildUrunDetayi(),
    );
  }

  void secilenIslem(secnekeler value) async {
    switch (value) {
      case secnekeler.sil:
        await dbHelper.sil(urun.id!);
        Navigator.pop(context, true);
        break;
      case secnekeler.guncelle:
        await dbHelper.guncelle(Urun.idLi(
            id: urun.id,
            ad: txtAd.text,
            aciklama: txtAciklama.text,
            fiyat: double.tryParse(txtFiyat.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  buildUrunDetayi() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(children: [
        buildAdField(),
        buildAciklamaField(),
        buildFiyatField(),
      ]),
    );
  }

  buildAdField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün Adı"),
      controller: txtAd,
    );
  }

  buildAciklamaField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün Açıklaması"),
      controller: txtAciklama,
    );
  }

  buildFiyatField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün Fiyatı"),
      controller: txtFiyat,
    );
  }
}
