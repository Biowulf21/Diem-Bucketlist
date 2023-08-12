import 'package:diem/utils/firebase_doc_id_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String id = FirebaseDocIDGenerator.createRandomID();
  test(
      'Expect firebase doc id generator to create a String doc id with 20 characters',
      () {
    expect(id.length, 20);
    expect(id.runtimeType, String);
    expect(id.isEmpty, false);
  });

  group('Check if format of Firebase doc id is correct', () {
    test(
        'Expect ID to be a String with 20 uppercase or lowercase characters with no numbers or special characters. ',
        () {
      //ID should be lowercase and uppercase letters only
      bool isValidID = id.contains(RegExp(r'[a-zA-Z]'));

      expect(isValidID, true);
    });
  });
}
