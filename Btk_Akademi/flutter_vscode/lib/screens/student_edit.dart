// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, no_logic_in_create_state, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_vscode/models/student.dart';
import 'package:flutter_vscode/validation/student_validator.dart';

class StudentEdit extends StatefulWidget {
  Student seciliOgrenci;
  StudentEdit(this.seciliOgrenci);

  @override
  State<StatefulWidget> createState() {
    return _StudentEditState(seciliOgrenci);
  }
}

class _StudentEditState extends State with StuduntValidationMixin {
  Student seciliOgrenci;
  _StudentEditState(this.seciliOgrenci);

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Öğrenci Güncelleme"),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeNameField(),
                buildSubmitButton()
              ],
            ),
          ),
        ));
  }

  buildFirstNameField() {
    return TextFormField(
      initialValue: seciliOgrenci.fristName,
      decoration: InputDecoration(labelText: "Öğrenci Adı :", hintText: "İsim"),
      validator: validateFirstName,
      onSaved: (String? value) {
        seciliOgrenci.fristName = value!;
      },
    );
  }

  buildLastNameField() {
    return TextFormField(
      initialValue: seciliOgrenci.lastName,
      decoration:
          InputDecoration(labelText: "Öğrenci Soyadı :", hintText: "Soyad"),
      validator: validateLastName,
      onSaved: (String? value) {
        seciliOgrenci.lastName = value!;
      },
    );
  }

  buildGradeNameField() {
    return TextFormField(
      initialValue: seciliOgrenci.grade.toString(),
      decoration:
          InputDecoration(labelText: "Aldığı Not :", hintText: "örn : 50"),
      validator: validateGrade,
      onSaved: (String? value) {
        seciliOgrenci.grade = int.parse(value!);
      },
    );
  }

  buildSubmitButton() {
    return ElevatedButton(
        child: Text("Güncelle"),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            setState(() {
              Navigator.pop(context);
            });
          }
        });
  }
}
