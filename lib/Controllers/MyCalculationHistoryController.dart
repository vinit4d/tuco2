import 'package:http/http.dart' as http;
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

class MyCalculationHistoryController extends GetxController {
  RxList<Map<String, dynamic>> arrTrips = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  initMethod() {
    arrTrips.clear();
    CalculationHistoryResponse();
  }

  Future<http.Response> CalculationHistoryAPI() async {
    final endPoints = 'calculation-history/list';

    showLoaderGetX();
    final response =
        await API.instance.get(endPoint: endPoints, isHeader: true);
    hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  CalculationHistoryResponse() async {
    final response = await CalculationHistoryAPI();
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);
      // final dictDashboardData =
      //     Map<String, dynamic>.from(dictData['Dashboard']);

      debugPrint(dictData.toString());

      arrTrips.value = List<Map<String, dynamic>>.from(dictData['trips']);
      debugPrint("arrTrips  ${arrTrips.length}");
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
}
