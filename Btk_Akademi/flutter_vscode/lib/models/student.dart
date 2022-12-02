// ignore_for_file: unnecessary_this, duplicate_ignore, avoid_return_types_on_setters, empty_constructor_bodies, unused_field

class Student {
  late int id;
  late String fristName;
  late String lastName;
  late int grade;
  late String _status;

  Student(this.fristName, this.lastName, this.grade) {}

  Student.withId(this.id, this.fristName, this.lastName, this.grade) {}
  Student.without();

  String get getfirstName {
    return "Öğrenci - ${this.fristName}";
  }

  void set setFirstName(String value) {
    this.fristName = value;
  }

  String get getStatus {
    String status = "Kaldı";
    if (this.grade >= 50) {
      status = "Geçti";
    } else if (this.grade >= 40) {
      status = "Bütünleme";
    }
    return status;
  }
}
