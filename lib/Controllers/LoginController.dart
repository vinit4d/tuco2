import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';

class LoginController extends GetxController {
  RxBool isRememberMe = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  reset() {
    isRememberMe.value = false;
    isLoading.value = false;

    email.text = '';
    password.text = '';
  }

  loginButton() async {
    final paramsBody = {
      'email': email.text,
      'password': password.text,
    };

    debugPrint(paramsBody.toString());
    final response = await loginAPI(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      dictData = Map<String, dynamic>.from(dictBody['data']);
      // final dictUser = Map<String, dynamic>.from(dictData['user']);

      // debugPrint(dictUser.toString());
      debugPrint(dictData.toString());

      if (isRememberMe.value) {
        // dictUser.userSaved();
        dictData.userSaved();
      }
      Get.to(BottomNavBarCustom());
    } else {
      if (dictBody['data'] != null) {
        final dictData = Map<String, dynamic>.from(dictBody['data']);
        // final arrData = List<String>.from(dictData['email']);
        final arrData = List<String>.from(dictData[dictData.keys.first]);
        arrData.first.showError();
      } else if (dictBody['message'] != null) {
        dictBody['message'].toString().showError();
      }
    }
  }

  Future<http.Response> loginAPI(Map<String, dynamic> paramsBody) async {
    isLoading.value = true;
    final response = await API.instance
        .post(endPoint: APIEndPoints.kLogin, params: paramsBody);
    isLoading.value = false;

    update();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
