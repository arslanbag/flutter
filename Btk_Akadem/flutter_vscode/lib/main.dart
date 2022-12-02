// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_vscode/models/student.dart';
import 'package:flutter_vscode/screens/student_add.dart';
import 'package:flutter_vscode/screens/student_edit.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Student> ogrencilerModel = [
    Student.withId(1, "Aykut", "Arslanbağ", 100),
    Student.withId(2, "Test1", "A", 35),
    Student.withId(3, "Test2", "b", 40),
    Student.withId(4, "Test3", "C", 20)
  ];

  String notSonucBaslik = "Bilgilendirme";
  String mesaj = "Öğrenci Takip sistemi";
  String button = "Sonuçları göster";

  Student seciliOgrenci = Student.withId(-1, "", "", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mesaj),
        ),
        body: buildBody(context));
  }

  void alertGoster(BuildContext context, String notMesaj) {
    var alert = AlertDialog(
      title: Text(notSonucBaslik),
      content: Text(notMesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: ogrencilerModel.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == -1) {
                    seciliOgrenci = ogrencilerModel[index];
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2016/08/20/05/51/avatar-1606939_960_720.png"),
                    ),
                    title: Text(ogrencilerModel[index].fristName +
                        " " +
                        ogrencilerModel[index].lastName),
                    subtitle: Text(
                        "Sınavdan aldığı Not : ${ogrencilerModel[index].grade} [${ogrencilerModel[index].getStatus}]"),
                    trailing: buildStatusIcon(ogrencilerModel[index].grade),
                    onTap: () {
                      setState(() {
                        seciliOgrenci = ogrencilerModel[index];
                      });
                    },
                  );
                })),
        Text("Seçili Öğrenci :" +
            seciliOgrenci.fristName +
            " " +
            seciliOgrenci.lastName),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 3.0),
                      Text("Yeni Ekle"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentAdd(ogrencilerModel)));
                  }),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Colors.greenAccent),
                  child: Row(
                    children: [
                      Icon(Icons.update),
                      SizedBox(width: 3.0),
                      Text("Güncelle"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentEdit(seciliOgrenci)));
                  }),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 3.0),
                      Text("Sil"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      ogrencilerModel.remove(seciliOgrenci);
                      alertGoster(
                          context, "Silindi : " + seciliOgrenci.fristName);
                    });
                  }),
            )
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int not) {
    if (not >= 50) {
      return const Icon(Icons.done);
    } else if (not >= 40) {
      return const Icon(Icons.album);
    } else {
      return const Icon(Icons.clear);
    }
  }
}
