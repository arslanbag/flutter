// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, no_logic_in_create_state, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_vscode/models/student.dart';
import 'package:flutter_vscode/validation/student_validator.dart';

class StudentAdd extends StatefulWidget {
  List<Student> ogrenciler;
  StudentAdd(this.ogrenciler);
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(ogrenciler);
  }
}

class _StudentAddState extends State with StuduntValidationMixin {
  List<Student> ogrenciler;
  _StudentAddState(this.ogrenciler);
  var ogrenci = Student.without();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Öğrenci Kayıt"),
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
      decoration: InputDecoration(labelText: "Öğrenci Adı :", hintText: "İsim"),
      validator: validateFirstName,
      onSaved: (String? value) {
        ogrenci.fristName = value!;
      },
    );
  }

  buildLastNameField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Öğrenci Soyadı :", hintText: "Soyad"),
      validator: validateLastName,
      onSaved: (String? value) {
        ogrenci.lastName = value!;
      },
    );
  }

  buildGradeNameField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Aldığı Not :", hintText: "örn : 50"),
      validator: validateGrade,
      onSaved: (String? value) {
        ogrenci.grade = int.parse(value!);
      },
    );
  }

  buildSubmitButton() {
    return ElevatedButton(
        child: Text("Kaydet"),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            saveStudent();

            setState(() {
              ogrenciler.add(ogrenci);
              Navigator.pop(context);
            });
          }
        });
  }

  void saveStudent() {
    print(ogrenci.fristName);
    print(ogrenci.lastName);
    print(ogrenci.grade);
  }
}
