import 'package:http/http.dart' as http;
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

import '../Views/AddTransportation.dart';

class TripScreenController extends GetxController {
  RxString selectedRoundTrip = 'Select a value'.obs;
  RxBool isLoading = false.obs;

  RxString totalEmission = '0'.obs;

  RxList<String> arrRoundTrip = [
    'Yes',
    'No',
  ].obs;

  Rx<TextEditingController> controllerFrom = TextEditingController().obs;
  Rx<TextEditingController> controllerTo = TextEditingController().obs;

  Rx<TextEditingController> controllerRoundTrip = TextEditingController().obs;
  Rx<TextEditingController> controllerStartDates = TextEditingController().obs;

  String passengers = '1';
  String totalTripDays = '1';

  initCustom() {
    controllerRoundTrip.value.text = 'No';

    // controllerFrom.value.text = '';
    // controllerTo.value.text = '';
    // controllerRoundTrip.value.text = '';
    // controllerStartDates.value.text = '';

    update();
  }

  continueButton(context) async {
    final paramsBody = {
      'from': controllerFrom.value.text,
      'to': controllerTo.value.text,
      'round_trip': (selectedRoundTrip.toLowerCase() == 'yes') ? '1' : '0',
      // 'start_date': controllerStartDates.value.text,
      'start_date': '2023-04-03',
      'trip_days': int.parse(totalTripDays).toString(),
      'peoples': int.parse(passengers).toString()
    };

    debugPrint(paramsBody.toString());

    final response = await createTripAPI(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);
      final dictTrip = Map<String, dynamic>.from(dictData['trip']);
      tripID = dictTrip['id'].toString();

      debugPrint(tripID.toString());

      navigateMultiBottom(
          context,
          AddTransportation(
            tripID: tripID,
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

  Future<http.Response> createTripAPI(Map<String, dynamic> paramsBody) async {
    isLoading.value = true;
    final response = await API.instance.post(
        endPoint: APIEndPoints.kCreateTrip, params: paramsBody, isHeader: true);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
