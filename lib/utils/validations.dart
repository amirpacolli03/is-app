class AppValidations {
  static String requiredFieldValidation(String value) {
    if (value.isEmpty) {
      return "This field can not be empty";
    }
    return null;
  }

  static String minimumLengthValidation(String value) {
    if (value.length < 3) {
      return "This field should be at least 3 caracters";
    }
    return null;
  }

  static String descriptionFieldValidation(String value) {
    if (value.length < 20) {
      return "This field should be at least 20 caracters";
    }
    return null;
  }
}
