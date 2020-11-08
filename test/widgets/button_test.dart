import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scibble/widgets/button.dart';

void main() {
  group('Button', () {
    testWidgets('Render test', (WidgetTester tester) async {
      final button = Button(
        onPress: () => print("pressed"),
        child: Text('test button'),
        color: ButtonColor.primary,
      );
      await tester.pumpWidget(Directionality(textDirection: TextDirection.ltr, child: button));
      final buttonText = find.text('test button');
      expect(buttonText, findsOneWidget);
    });
  });
}
