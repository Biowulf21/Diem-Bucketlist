class InputValidator {
  String? input;
  String? errorMessage;

  InputValidator({
    required this.input,
  });

  InputValidator isRequired() {
    if (input == "" || input!.isEmpty) {
      errorMessage = "This value cannot be null.";
    }
    return this;
  }

  InputValidator lengthIsLessThan({required int desiredLength}) {
    if (input!.length < desiredLength) {
      errorMessage =
          "The input is less than the desired length of ${desiredLength} characters.";
    }
    return this;
  }

  InputValidator maxLength({required int maxLength}) {
    if (input!.length > maxLength) {
      errorMessage =
          "The input is too long for a max length of ${maxLength} characters.";
    }
    return this;
  }

  InputValidator hasAlphaCharacters() {
    if (input!.contains(RegExp(r'[A-Z]'))) {
      return this;
    }

    errorMessage = "The input does not have an uppercase character.";
    return this;
  }

  InputValidator hasNumericCharacters() {
    if (input!.contains(RegExp(r'[0-9]'))) {
      return this;
    }

    errorMessage = "The input does not have a numeric character.";
    return this;
  }

  InputValidator hasSpecialCharacter() {
    if (input!
        .contains(RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' "'" ']'))) {
      return this;
    }

    errorMessage = "The input does not have a special character.";
    return this;
  }

  String? validate() {
    return errorMessage;
  }
}
