import 'dart:math';

class FirebaseDocIDGenerator {
  static String generateRandomString() {
    final random = Random();
    final codeUnits = List.generate(20, (index) {
      final isUppercase = random.nextBool();
      final start = isUppercase ? 65 : 97;
      final end = isUppercase ? 90 : 122;
      return random.nextInt(end - start + 1) + start;
    });

    return String.fromCharCodes(codeUnits);
  }
}
