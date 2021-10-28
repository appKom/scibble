import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:scibble/models/authentication/token.dart';

const String mockTokenString =
    '{"access_token":"fake_access_token","refresh_token":"fake_refresh_token","token_type":"code","expires_in":3600,"id_token":"fake_id_token"}';
const String mockExpiredTokenString =
    '{"access_token":"fake_access_token","refresh_token":"fake_refresh_token","token_type":"code","expires_in":-3600,"id_token":"fake_id_token"}';

void main() {
  group("Token model", () {
    final mockToken = Token.fromJson(json.decode(mockTokenString));
    final expiredMockToken =
        Token.fromJson(json.decode(mockExpiredTokenString));
    test('Test serializing', () {
      expect(mockToken.accessToken, "fake_access_token");
      expect(mockToken.refreshToken, "fake_refresh_token");
      expect(mockToken.tokenType, "code");
      expect(mockToken.idToken, "fake_id_token");
      expect(mockToken.isExpired, false);
      expect(expiredMockToken.isExpired, true);
    });
  });
}
