


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/Controllers/LoginController.dart';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('loginAPI_test', (WidgetTester tester) async {
    // await tester.runAsync(() async {
    final loginController = LoginController();
    final paramsBody = {
      'email': 'john@gmail.com',
      'password': 'Addweb@123'
    };
    final status = await loginController.loginAPI(paramsBody);
  // });
  });
}


