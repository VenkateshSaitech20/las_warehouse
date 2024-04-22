class Validations {
  bool hasOnlySpace(String value) {
    bool b = RegExp(r'^\s*$').hasMatch(value);
    return b;
  }

  bool hasOnlyNumber(String value) {
    bool b = RegExp(r'^[0-9]+$').hasMatch(value);
    return b;
  }

  bool nameField(String value) {
    bool b = RegExp(r'^[a-zA-Z0-9&_-\s]+$').hasMatch(value);
    return b;
  }
}
