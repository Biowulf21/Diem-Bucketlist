class InputValidator {
  String input;
  String? errorMessage;

  InputValidator({
    required this.input,
  });

  void isNotNullable() {
    if (input == "" || input.isEmpty) {
      errorMessage = "This value cannot be null";
    }
  }

  void lengthIsLessThan(int desiredLength) {
    if (input.length < desiredLength) {
      errorMessage =
          "The input is less than the desired length of ${desiredLength} characters.";
    }
  }

  void maxLength(int maxLength) {
    if (input.length > maxLength) {
      errorMessage =
          "The input is too long for a max length of ${maxLength} characters.";
    }
  }

  void hasAlphaCharacters() {
    if (input.contains(RegExp(r'[A-Z]'))) {}

    errorMessage = "The input does not have an uppercase character.";
  }

  void hasNumericCharacters() {
    if (input.contains(RegExp(r'[0-9]'))) {}

    errorMessage = "The input does not have a numeric character.";
  }

  void hasSpecialCharacter() {
    if (input
        .contains(RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' "'" ']'))) {}

    errorMessage = "The input does not have a special character.";
  }

  String? validate() {
    return errorMessage;
  }
}
