import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SurveyDemo());
}

class SurveyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Btk Akademi Flutter Eğitim',
      theme: ThemeData.light(),
      home: const Scaffold(
        body: Center(child: SurveyList()),
      ),
    );
  }
}

/// Holds all example app films
class SurveyList extends StatefulWidget {
  const SurveyList({Key? key}) : super(key: key);
  @override
  _SurveyList createState() => _SurveyList();
}

class _SurveyList extends State {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("dilanketi").snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          } else {
            return buildBody(context, snapshot.data!.docs);
          }
        }));
  }

  Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children:
          snapshot.map<Widget>((data) => buildListItem(context, data)).toList(),
    );
  }

  buildListItem(BuildContext context, DocumentSnapshot data) {
    final row = Anket.fromSnapshot(data);
    return Padding(
        key: ValueKey(row.isim),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0)),
          child: ListTile(
            title: Text(row.isim.toString()),
            trailing: Text(row.oy.toString()),
            onTap: () => //row.reference.update({'Oy': row.oy! + 1}),
                FirebaseFirestore.instance.runTransaction((transaction) async {
              final freshSnapshot =
                  await transaction.get(row.reference); //snapshot
              final fresh = Anket.fromSnapshot(freshSnapshot); //Ankets
              await transaction.update(row.reference, {'Oy': row.oy! + 1});
            }),
          ),
        ));
  }
}

class Anket {
  String? isim;
  int? oy;
  DocumentReference reference;

  Anket.fromMap(Map map, {required this.reference})
      : assert(map["isim"] != null),
        assert(map["Oy"] != null),
        isim = map["isim"],
        oy = int.parse(map["Oy"].toString());

  Anket.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);
}

//Test-1
class _SurveyListTest extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anket'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('dilanketi').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
              children:
                  snapshot.requireData.docs.map((DocumentSnapshot document) {
            return ListTile(
              title: Text(document['isim']),
              subtitle: Text(document['Oy'].toString()),
            );
          }).toList());
        },
      ),
    );
  }
}

//Test-2
final fakeSnapshots = [
  {"isim": "C#", "oy": 3},
  {"isim": "Java", "oy": 4},
  {"isim": "Dart", "oy": 5},
  {"isim": "C++", "oy": 7},
  {"isim": "Python", "oy": 90},
  {"isim": "Perl", "oy": 2},
];
