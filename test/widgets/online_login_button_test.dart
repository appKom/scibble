import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scibble/widgets/button.dart';
import 'package:scibble/widgets/online_login_button.dart';

void main() {
  group('Online Login Button', () {
    testWidgets('Render disabled', (WidgetTester tester) async {
      final buttonKey = UniqueKey();
      final loginButton = LoginButton(key: buttonKey);
      await tester.pumpWidget(Directionality(textDirection: TextDirection.ltr, child: loginButton));
      final loginText = find.text('Logg inn gjennom Online');
      final FlatButton button = tester
          .widget(find.descendant(of: find.byKey(buttonKey), matching: find.byType(FlatButton)));
      expect(loginText, findsOneWidget);
      expect(false, button.enabled);
    });
    testWidgets('Render enabled', (WidgetTester tester) async {
      final buttonKey = UniqueKey();
      final loginButton = LoginButton(
        key: buttonKey,
        goToLoginView: () => print('mock'),
      );
      await tester.pumpWidget(Directionality(textDirection: TextDirection.ltr, child: loginButton));
      final loginText = find.text('Logg inn gjennom Online');
      final FlatButton button = tester
          .widget(find.descendant(of: find.byKey(buttonKey), matching: find.byType(FlatButton)));
      expect(loginText, findsOneWidget);
      expect(true, button.enabled);
    });
  });
}
