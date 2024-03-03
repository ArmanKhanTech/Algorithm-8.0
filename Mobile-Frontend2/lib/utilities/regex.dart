class Regex {
  static String? validateEmail(String? value, [bool isRequired = true]) {
    if (value!.isEmpty && isRequired) {
      return 'Invalid Email';
    }
    final RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!emailExp.hasMatch(value) && isRequired) {
      return 'Invalid Email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Invalid Password';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value!.length > 100 || value.isEmpty) {
      return 'Invalid Name';
    }
    return null;
  }

  static String? validateType(String? value) {
    if (value == null ||
        value.length > 100 ||
        value.isEmpty ||
        value != 'Admin' && value != 'Judge' && value != 'Hosp') {
      return 'Invalid Type';
    }
    return null;
  }
}
