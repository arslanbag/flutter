import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlflitdemo/modelsR/urun_.dart';

class DbHelper {
  Database? _db;

  Future<Database?> get db async {
    _db = (_db == null) ? await initialized() : _db;
    return _db;
  }

  Future<Database?> initialized() async {
    String dbYol = join(await getDatabasesPath(), "flutteregitim.db");
    var flutterEgitimDb =
        await openDatabase(dbYol, version: 1, onCreate: olusturDb);
    return flutterEgitimDb;
  }

  void olusturDb(Database db, int version) async {
    await db.execute(
        "Create table urunler(id integer primary key, ad text, aciklama text, fiyat integer)");
  }

  Future<List<Urun>> urunleriGetir() async {
    Database? db = await this.db;
    var result = await db?.rawQuery('SELECT * FROM urunler');
    return List.generate(result!.length, (i) {
      return Urun.idLi(
          id: int.parse(result[i]["id"].toString()),
          ad: result[i]["ad"].toString(),
          aciklama: result[i]["aciklama"].toString(),
          fiyat: double.parse(result[i]["fiyat"].toString()));
    });
  }

  Future<int> ekle(Urun urun) async {
    Database? db = await this.db;
    var result = await db?.insert("urunler", urun.toMap());
    return result!;
  }

  Future<int> sil(int id) async {
    Database? db = await this.db;
    var result = await db?.rawDelete("delete from urunler where id=$id");
    return result!;
  }

  Future<int> guncelle(Urun urun) async {
    Database? db = await this.db;
    var result = await db
        ?.update("urunler", urun.toMap(), where: "id=?", whereArgs: [urun.id]);
    return result!;
  }
}
