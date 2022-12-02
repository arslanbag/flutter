import 'package:flutter/material.dart';
import 'package:sqlflitdemo/dataR/db_helper.dart';
import '../modelsR/urun_.dart';

class UrunEkle extends StatefulWidget {
  const UrunEkle({super.key});

  @override
  State<StatefulWidget> createState() {
    return UrunEkleState();
  }
}

class UrunEkleState extends State {
  var txtAd = TextEditingController();
  var txtAciklama = TextEditingController();
  var txtFiyat = TextEditingController();
  DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Ürün Ekle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          buildAdField(),
          buildAciklamaField(),
          buildFiyatField(),
          buildKaydetButton()
        ]),
      ),
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

  buildKaydetButton() {
    return TextButton(
        onPressed: () {
          urunEkle();
        },
        child: const Text("Ekle"));
  }

  void urunEkle() async {
    await dbHelper.ekle(Urun(
        ad: txtAd.text,
        aciklama: txtAciklama.text,
        fiyat: double.tryParse(txtFiyat.text)));
    Navigator.pop(context, true);
  }
}
