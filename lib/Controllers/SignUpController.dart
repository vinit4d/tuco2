import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';

class SignUpController extends GetxController {
  RxBool isAcceptTheTermsAndConditions = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  reset() {
    isAcceptTheTermsAndConditions.value = false;
    isLoading.value = false;
  }

  signUpButton() async {
    final paramsBody = {
      'first_name': firstName.text,
      'last_name': lastName.text,
      'email': email.text,
      'password': password.text,
    };

    final response = await signUpAPI(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      dictData = Map<String, dynamic>.from(dictBody['data']);
      // final dictUser = Map<String, dynamic>.from(dictData['user']);

      // debugPrint(dictUser.toString());
      // dictUser.userSaved();

      debugPrint(dictData.toString());
      dictData.userSaved();

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

  Future<http.Response> signUpAPI(Map<String, dynamic> paramsBody) async {
    isLoading.value = true;
    final response = await API.instance
        .post(endPoint: APIEndPoints.kRegister, params: paramsBody);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
