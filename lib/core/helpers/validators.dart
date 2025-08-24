class Validators {
  static bool isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z]\w*([_.-]\w*)?@[a-zA-Z\d]+([.-][a-zA-Z\d]+)*\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  static bool isNotValidEmail(String email) => !isValidEmail(email);

  static bool isValidPassword(String password) {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9].*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(password);
  }

  static bool isNotValidPassword(String password) => !isValidPassword(password);

  static bool isSaudiPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^05[0-9]{8}$').hasMatch(phoneNumber);
  }

  static bool isValidSaudiID(String id) {
    if (!RegExp(r'^[12]\d{9}$').hasMatch(id)) return false;
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      int digit = int.parse(id[i]);
      if (i % 2 == 0) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
    }
    int checkDigit = int.parse(id[9]);
    int calculatedCheck = (10 - (sum % 10)) % 10;

    return checkDigit == calculatedCheck;
  }
}
