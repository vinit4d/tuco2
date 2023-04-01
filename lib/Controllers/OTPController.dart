import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';
import '../Views/ForgotPasswordEmailVerification.dart';

class OTPController extends GetxController {
  // RxBool isSubmitOTP = false.obs;
  RxInt countDownForResendOTP = 300.obs;

  RxBool isLoading = false.obs;
  String textOTP = '';
  String emailFromForgotPassword = '';

  initCustom() {
    // isSubmitOTP.value = false;
    countDownForResendOTP.value = 300;

    timerResendOTP();
  }

  timerResendOTP() {
    countDownForResendOTP.value = countDownForResendOTP.value - 1;
  }

  submitOTPButton() async {
    final paramsBody = {
      'email': emailFromForgotPassword,
      'otp': textOTP,
    };

    debugPrint(paramsBody.toString());
    final response = await verifyOTP(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      Get.to(ForgotPasswordEmailVerification(
        emailFromForgotPassword: emailFromForgotPassword,
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

  Future<http.Response> verifyOTP(Map<String, dynamic> paramsBody) async {
    isLoading.value = true;
    final response = await API.instance
        .post(endPoint: APIEndPoints.kVerifyOTP, params: paramsBody);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
