import 'package:http/http.dart' as http;
import 'package:tuco2/Views/OTPScreen.dart';

import '../ExportFiles/ExportFilesMust.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController controllerEmail = TextEditingController();

  RxBool isLoading = false.obs;

  initCustom() {
    isLoading.value = false;
    controllerEmail.text = '';
  }

  forgotPasswordButton() async {
    final paramsBody = {
      'email': controllerEmail.text,
    };

    debugPrint(paramsBody.toString());
    final response = await forgotPassword(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      Get.to(OTPScreen(
        emailFromForgotPassword: controllerEmail.text,
      ));
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

  Future<http.Response> forgotPassword(Map<String, dynamic> paramsBody) async {
    isLoading.value = true;
    final response = await API.instance
        .post(endPoint: APIEndPoints.kForgotPassword, params: paramsBody);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
