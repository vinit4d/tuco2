import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';
import '../Models/ChartData.dart';

class CarbonFootprintController extends GetxController {
  RxBool isLoading = false.obs;

  RxMap<String, dynamic> dictTrip = <String, dynamic>{}.obs;
  RxList<Map<String, dynamic>> arrTransports = <Map<String, dynamic>>[].obs;

  RxList<ChartData> arrCO2Emissions = <ChartData>[].obs;
  RxList<ChartData> arrCodeIntensity = <ChartData>[].obs;

  RxString totalEmission = '0'.obs;

  initCustom() {
    tripCalculations();
  }

  tripCalculations() async {
    final response = await tripCalculationsAPI();
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);

      dictTrip.value = Map<String, dynamic>.from(dictData['trip']);

      final dictBarData = Map<String, dynamic>.from(dictData['barData']);

      arrCO2Emissions.add(ChartData(
          'One', double.parse(dictBarData['my_co2_emissions'].toString())));

      arrCO2Emissions.add(ChartData(
          'Two', double.parse(dictBarData['average_emissions'].toString())));

      final dictCalculation =
          Map<String, dynamic>.from(dictTrip['calculation']);

      // final front_payment =
      //     Map<String, dynamic>.from(dictTrip['front_payment']);

      totalEmission.value = dictCalculation['total_emission'].toString();

      arrTransports.value =
          List<Map<String, dynamic>>.from(dictData['transports']);

      for (int i = 0; i < arrTransports.length; i++) {
        arrCO2Emissions.add(ChartData(
            arrTransports[i]['transport_type'].toString(),
            double.parse(arrTransports[i]['percentage'].toString())));
      }

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

  Future<http.Response> tripCalculationsAPI() async {
    showLoaderGetX();
    final response = await API.instance
        .get(endPoint: 'trip/${tripID}/calculations', isHeader: true);
    hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
