import 'package:http/http.dart' as http;
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

import '../Models/ChartData.dart';

class CalculationHisoryDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> arrTrips = <Map<String, dynamic>>[].obs;

  RxString from = ''.obs;
  RxString to = ''.obs;
  RxString via_1 = ''.obs;
  RxString via_2 = ''.obs;
  RxString via_3 = ''.obs;
  RxInt my_co2_emissions = 0.obs;
  RxInt average_emissions = 0.obs;
  RxInt trip_days = 0.obs;
  RxInt peoples = 0.obs;
  RxString start_date = ''.obs;
  RxString total_emission_per_person = ''.obs;
  RxDouble amount = 0.0.obs;
  RxInt total_emission = 0.obs;
  RxString image = ''.obs;

  RxList<Map<String, dynamic>> arrTransports = <Map<String, dynamic>>[].obs;

  RxList<ChartData> arrCO2Emissions = <ChartData>[].obs;

  initMethod(int historyId) {
    CalculationHistoryResponse(historyId);
    from.value = '';
  }

  Future<http.Response> CalculationHistoryDetailAPI(int historyId) async {
    // final endPoints = 'calculation-history/' + '307' + '/details';
    final endPoints = 'calculation-history/' + '$historyId' + '/details';

    isLoading.value = true;
    // showLoaderGetX();

    final response =
        await API.instance.get(endPoint: endPoints, isHeader: true);

    // hideLoader();
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  Future<http.Response> DeleteAPI(int historyId) async {
    //  calculation-history/21/delete
    final endPoints = 'calculation-history/' + '$historyId' + '/delete';

    isLoading.value = true;

    final response = await API.instance
        .delete(endPoint: endPoints, params: {}, isHeader: true);

    isLoading.value = false;
    debugPrint(response.toString());
    update();
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  CalculationHistoryResponse(int historyId) async {
    final response = await CalculationHistoryDetailAPI(historyId);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);
      // final dictDashboardData =
      //     Map<String, dynamic>.from(dictData['Dashboard']);

      debugPrint(dictData.toString());
      from.value = dictBody['data']['trip']['from'];
      to.value = dictBody['data']['trip']['to'];
      trip_days.value = dictBody['data']['trip']['trip_days'];
      peoples.value = dictBody['data']['trip']['peoples'];
      via_1.value = dictBody['data']['trip']['via_1'] == "null"
          ? ''
          : dictBody['data']['trip']['via_1'];
      via_2.value = dictBody['data']['trip']['via_2'] == "null"
          ? ''
          : dictBody['data']['trip']['via_2'];
      via_3.value = dictBody['data']['trip']['via_3'] == "null"
          ? ''
          : dictBody['data']['trip']['via_3'];
      start_date.value = dictBody['data']['trip']['start_date'];

      total_emission_per_person.value =
          dictBody['data']['trip']['calculation']['total_co2_per_person'];

      arrTransports.value =
          List<Map<String, dynamic>>.from(dictData['transports']);

      for (int i = 0; i < arrTransports.length; i++) {
        arrCO2Emissions.add(ChartData(
          arrTransports[i]['transport_type'].toString(),
          double.parse(arrTransports[i]['percentage'].toString()),
        ));
      }

      //front_payment json
      amount.value = dictBody['data']['trip']['front_payment']['amount'];
      image.value =
          dictBody['data']['trip']['front_payment']['project']['banner'];

      //calculation json
      total_emission.value =
          dictBody['data']['trip']['calculation']['total_emission'];
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

  DeleteAPIResponse(int historyId, BuildContext context) async {
    final response = await DeleteAPI(historyId);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      Navigator.pop(context);
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

  deleteOffsetDialog(BuildContext context, int historyId) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStylesCustom.textStyles_18.apply(
          color: Colors.black,
          // fontWeightDelta: 2
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Delete",
        style: TextStylesCustom.textStyles_18
            .apply(color: Colors.red, fontWeightDelta: 2),
      ),
      onPressed: () async {
        Get.back();

        DeleteAPIResponse(historyId, context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        "Are you sure ?",
        style: TextStylesCustom.textStyles_22.apply(fontWeightDelta: 2),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    //show the dialog..
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
