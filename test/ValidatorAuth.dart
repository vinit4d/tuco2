// ValidatorAuth


import 'package:flutter_test/flutter_test.dart';
import '../lib/Utils/ValidatorAuth.dart';

void main(){
  test('empty email test', () {
    var result = ValidatorAuth.email('');
    expect(result, 'Please enter email');
  });

  test('valid email test', () {
    var result = ValidatorAuth.email('mukesh@gmail.in');
    expect(result, null);
  });

  test('empty password test', () {
    var result = ValidatorAuth.password('');
    expect(result, 'Please enter password');
  });

  test('valid password test', () {
    const message = 'Password must have at least 8 characters \nPassword must have one uppercase \nPassword must have one lowercase  \nPassword must have one number \nPassword must have one special character';
    var result = ValidatorAuth.password('kjhkgkglkgkj');
    expect(result, message);
  });

  test('valid password test', (){
    var result = ValidatorAuth.password('Addweb@123');
    expect(result, null);
  });

  test('empty name test', () {
    var result = ValidatorAuth.firstName('');
    expect(result, 'First name must enter');
  });


}
