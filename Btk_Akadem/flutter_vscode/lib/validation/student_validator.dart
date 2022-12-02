class StuduntValidationMixin {
  String? validateFirstName(String? value) {
    if ((value?.length)! < 2) {
      return "İsim en az iki karakterli olmalı";
    }
    return null;
  }

  String? validateLastName(String? value) {
    if ((value?.length)! < 2) {
      return "İsim en az iki karakterli olmalı";
    }
    return null;
  }

  String? validateGrade(String? value) {
    if (int.parse(value.toString()) < 0 || int.parse(value.toString()) > 100) {
      return "not 0-100 arası olmalıdır!";
    }
    return null;
  }
}
