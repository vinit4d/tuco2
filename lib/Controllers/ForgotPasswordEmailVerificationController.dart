import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';

class ForgotPasswordEmailVerificationController extends GetxController {
  RxBool isLoading = false.obs;
  String emailFromForgotPassword = '';

  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  initCustom() {
    isLoading.value = false;
  }

  getNewPasswordButton() async {
    final paramsBody = {
      'email': emailFromForgotPassword,
      'password': password.text,
      'confirm_password': confirm_password.text,
    };

    debugPrint(paramsBody.toString());
    final response = await resetPassword(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      // Get.to(ForgotPasswordEmailVerification(
      //   emailFromForgotPassword: emailFromForgotPassword,
      // ));
      Get.close(3);
      dictBody['message'].toString().showSuccess();
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

  Future<http.Response> resetPassword(Map<String, dynamic> paramsBody) async {
    isLoading.value = true;
    final response = await API.instance
        .post(endPoint: APIEndPoints.kResetPassword, params: paramsBody);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
