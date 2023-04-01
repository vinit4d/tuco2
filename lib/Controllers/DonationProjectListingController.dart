import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';

class DonationProjectListingController extends GetxController {
  RxList<Map<String, dynamic>> arrProjects = <Map<String, dynamic>>[].obs;

  initCustom() {
    viewProjects();
  }

  viewProjects() async {
    final response = await viewProjectsAPI();
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);

      arrProjects.value = List<Map<String, dynamic>>.from(dictData['projects']);

      update();
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

  Future<http.Response> viewProjectsAPI() async {
    showLoaderGetX();
    final response = await API.instance
        .get(endPoint: APIEndPoints.kViewProjects, isHeader: true);
    hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
