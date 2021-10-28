import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:scibble/models/online_web/user.dart';

const String mockJsonUser =
    '{"id":1,"first_name":"Ola","last_name":"Nordmann","username":"OlaN","nickname":"Ola the N","ntnu_username":"olanord","year":1,"email":"ola@nordmann.no","online_mail":"ola.nordmann@online.ntnu.no","phone_number":"11223344","address":"Høgskolevegen 5","website":"online.ntnu.no","github":"https://github.com/appkom","linkedin":null,"positions":[],"special_positions":[],"rfid":"99887766","field_of_study":2,"started_date":"2010-01-01","compiled":true,"infomail":true,"jobmail":true,"zip_code":"7034","allergies":"Dårlig S","mark_rules_accepted":true,"gender":"Undisclosed","bio":"Elsker Online!","saldo":999,"is_committee":true,"is_member":true,"image":"https://www.gravatar.com/avatar/bea5d06f24bce0657e3e2a622a9d4a94?d=https%3A%2F%2Fonline.ntnu.no%2Fstatic%2Fimg%2Fprofile_default_male.png&s=240","has_expiring_membership":false}';

void main() {
  group("User model", () {
    final mockUser = User.fromJson(json.decode(mockJsonUser));
    test('Test serializing', () {
      expect(mockUser.id, 1);
      expect(mockUser.ntnuUsername, "olanord");
      expect(mockUser.onlineMail, "ola.nordmann@online.ntnu.no");
    });
    test('Test deserializing', () {
      expect(mockJsonUser, json.encode(mockUser.toJson()));
    });
  });
}
