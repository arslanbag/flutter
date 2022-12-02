import 'package:flutter/material.dart';
import 'package:sqlflitdemo/dataR/db_helper.dart';
import 'package:sqlflitdemo/modelsR/urun_.dart';
import 'package:sqlflitdemo/screensR/urun_detay.dart';
import 'package:sqlflitdemo/screensR/urun_ekle.dart';

class UrunListele extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UrunListeleState();
  }
}

class UrunListeleState extends State {
  var urunSayisi = 0;
  DbHelper dbHelper = DbHelper();
  late List<Urun> urunler;

  @override
  void initState() {
    getirUrunleri();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Listesi"),
      ),
      body: buildUrunListesi(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gitUrunEkleme(context);
        },
        tooltip: "Yeni Ürün ekle",
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView buildUrunListesi() {
    return ListView.builder(
      itemCount: urunSayisi,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.cyan,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text("P"),
            ),
            title: Text(urunler[position].ad.toString()),
            subtitle: Text(urunler[position].aciklama.toString()),
            onTap: () {
              getirDetaylari(urunler[position]);
            },
          ),
        );
      },
    );
  }

  void gitUrunEkleme(BuildContext context) async {
    bool? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UrunEkle()));
    print("NNNNNNNNNN");
    if (result != null) {
      if (result) {
        getirUrunleri();
        print("AAAAAAAAAAAA");
      }
    }
  }

  void getirUrunleri() async {
    var urunlerGelecek = dbHelper.urunleriGetir();
    urunlerGelecek.then((data) {
      setState(() {
        urunler = data;
        urunSayisi = data.length;
      });
    });
  }

  void getirDetaylari(Urun urun) async {
    bool? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => UrunDetay(urun)));

    if (result != null) {
      if (result) {
        getirUrunleri();
      }
    }
  }
}
