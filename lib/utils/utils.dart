class Utils {
  static bool isValidEmail(String email) {
    final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return regex.hasMatch(email);
  }

  static bool passwordLength(String password) {
    return password.length > 3 ? true : false;
  }
}
