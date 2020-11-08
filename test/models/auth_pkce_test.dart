import 'package:flutter_test/flutter_test.dart';
import 'package:scibble/models/auth_pkce.dart';

void main() {
  group('AuthPKCE model', () {
    final mockAuthPKCE = AuthPKCE('123456789');
    test('Test SHA256 always same output', () {
      String sha256Verifier = AuthPKCE.stringToSha256(mockAuthPKCE.verifier);
      String sha256ClientId = AuthPKCE.stringToSha256(mockAuthPKCE.clientId);
      expect(sha256Verifier, mockAuthPKCE.challenge);
      expect(sha256ClientId, isNot(mockAuthPKCE.challenge));
    });
  });
}
