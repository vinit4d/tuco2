

// flutter run -t test/Login.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/Views/Login.dart';


void main() {
  testWidgets('LoginScreen', (WidgetTester tester) async {
    await tester.runAsync(() async {
      Login loginPage = Login();
      await tester.pumpWidget(buildTestableWidget(loginPage));

      Finder emailTextFormField = find.byKey(const Key('email'));
      await tester.enterText(emailTextFormField, 'raja@gmail.in');
      Finder passwordField = find.byKey(const Key('password'));
      await tester.enterText(passwordField, 'Raja@123');

      Finder loginButton = find.byKey(const Key('Login'));
      await tester.tap(loginButton);

      await tester.pump(const Duration(seconds: 3));

      Finder loginLoader = find.byKey(const Key('LoginLoader'));

      // if (loginLoader == findsOneWidget) {
        expect(loginLoader, findsOneWidget);

      Future.delayed(const Duration(seconds: 5), () {
          Finder loginButtonAfterLoader = find.byKey(const Key('Login'));
          expect(loginButtonAfterLoader, findsOneWidget);
        });
      // } else {
      //   debugPrint("Validation Error ... ");
      // }

    });
  });



  // testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
  //   Login loginPage = Login();
  //   await tester.pumpWidget(buildTestableWidget(loginPage));
  //
  //   Finder emailTextFormField = find.byKey(const Key('email'));
  //   await tester.enterText(emailTextFormField, 'raja@gmail.com');
  //   Finder passwordField = find.byKey(const Key('password'));
  //   await tester.enterText(passwordField, 'Raja@123');
  //
  //   Finder loginButton = find.byKey(const Key('Login'));
  //   await tester.tap(loginButton);
  //
  //   await tester.pump();
  //
  //   Finder loginLoader = find.byKey(const Key('LoginLoader'));
  //   // print(loginLoader == findsOneWidget);
  //   expect(loginLoader, findsOneWidget);
  // });
}


Widget buildTestableWidget(Widget widget) {
  return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(home: widget)
  );
}
