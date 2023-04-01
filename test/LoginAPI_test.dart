// LoginAPI_test
// ValidatorAuth

import 'package:flutter_test/flutter_test.dart';
import '../lib/Controllers/LoginController.dart';

void main() {
  test('loginAPI', () async {
    final loginController = LoginController();

    final paramsBody = {
      'email': 'john@gmail.com',
      'password': 'Addweb@123'
    };
    loginController.loginAPI(paramsBody);
  });
}
