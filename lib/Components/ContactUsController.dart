import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';

class ContactUsController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController description = TextEditingController();

  initCustom() {
    isLoading.value = false;

    email.text = '';
    name.text = '';
    description.text = '';
  }

  sendMessageButton() async {
    final paramsBody = {
      'name': name.text,
      'email': email.text,
      'phone': '9876543210',
      'description': description.text,
    };

    debugPrint(paramsBody.toString());
    final response = await loginAPI(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);
      // Navigator.pop(Get.context!);
      dictBody['message'].toString().showSuccess();

      initCustom();
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
    final response = await API.instance.post(
        endPoint: APIEndPoints.kContactUs, params: paramsBody, isHeader: true);
    isLoading.value = false;

    update();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
