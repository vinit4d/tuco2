import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/Views/Login.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('LoginScreen', (WidgetTester tester) async {
    await tester.runAsync(() async {
      Login loginPage = Login();
      await tester.pumpWidget(buildTestableWidget(loginPage));

      Finder emailTextFormField = find.byKey(const Key('email'));
      await tester.enterText(emailTextFormField, 'raja@gmail.com');
      Finder passwordField = find.byKey(const Key('password'));
      await tester.enterText(passwordField, 'Raja@123');

      Finder loginButton = find.byKey(const Key('Login'));
      await tester.tap(loginButton, warnIfMissed: false);

      Finder loginLoader = find.byKey(const Key('LoginLoader'));
      expect(loginLoader, findsOneWidget);

      await addDelay(5);
      await tester.pumpAndSettle();

      Finder loginButtonAfterLoader = find.byKey(const Key('Login'));
      expect(loginButtonAfterLoader, findsOneWidget);
    });
  });
}

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(
      data: const MediaQueryData(), child: MaterialApp(home: widget));
}

Future<void> addDelay(int seconds) async {
  await Future<void>.delayed(Duration(seconds: seconds));
}
