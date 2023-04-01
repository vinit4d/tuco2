import 'package:http/http.dart' as http;
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:tuco2/Views/Transportation_Form.dart';

class AddTransportationController extends GetxController {
  // RxString totalEmission = '0'.obs;

  RxString total_co2 = '0'.obs;

  RxList<Map<String, dynamic>> arrTransports = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> arrTransportsList = <Map<String, dynamic>>[].obs;

  RxList<bool> arrSelected = <bool>[].obs;

  RxBool isLoading = false.obs;

  String tripID = '';
  String transportID = '';

  String selectedTransportImage = '';
  String selectedTransportName = '';

  initCustom() {
    tripCalculations();
    transport();
  }

  transport() async {
    final response = await transportAPI();
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);
      arrTransports.value =
          List<Map<String, dynamic>>.from(dictData['transports']);

      for (int i = 0; i < arrTransports.length; i++) {
        arrSelected.add((i == 0) ? true : false);
        // arrSelected.add(false);
      }

      transportID = arrTransports[0]['id'].toString();
      selectedTransportImage = arrTransports[0]['image'].toString();
      selectedTransportName = arrTransports[0]['name'].toString();
      transportList();

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

  Future<http.Response> transportAPI() async {
    // showLoaderGetX();

    final response = await API.instance
        .get(endPoint: APIEndPoints.kTransports, isHeader: true);
    // hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  selectTransportation(int index) {
    for (int i = 0; i < arrSelected.length; i++) {
      if (i == index) {
        arrSelected[i] = true;
      } else {
        arrSelected[i] = false;
      }
    }

    update();

    transportID = arrTransports[index]['id'].toString();

    selectedTransportImage = arrTransports[index]['image'].toString();
    selectedTransportName = arrTransports[index]['name'].toString();

    transportList();
  }

  addNewFlight() {
    showTransportation_Form(transportID, tripID);
  }

  updateNewFlight(int index, {List<Map<String, dynamic>>? arrTransformData}) {
    final transportationTripID = arrTransportsList[index]['id'].toString();
    showTransportation_Form(transportID, tripID,
        arrTransformData: arrTransformData,
        transportationTripID: transportationTripID);
  }

  transportList() async {
    final response = await transportListAPI();
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);
      arrTransportsList.value =
          List<Map<String, dynamic>>.from(dictData['rows']);

      // departureFrom(arrTransportsList[0]['user_data']);
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

  Future<http.Response> transportListAPI() async {
    showLoaderGetX();
    final response = await API.instance.get(
        endPoint: 'trip/${tripID}/transport-list/${transportID}',
        isHeader: true);
    hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  String labelFrom(String user_data) {
    final dictUserData = json.decode(user_data);

    // final dictUserData2 = json.decode(dictUserData);
    final arrUserData = List<Map<String, dynamic>>.from(dictUserData);

    print(arrUserData[0]['label'].toString());

    return arrUserData[0]['label'].toString();
  }

  String valueFrom(String user_data) {
    final dictUserData = json.decode(user_data);
    // final dictUserData2 = json.decode(dictUserData);
    final arrUserData = List<Map<String, dynamic>>.from(dictUserData);

    // print(arrUserData[0]['label'].toString());
    // print(arrUserData[0]['value'].toString());

    return arrUserData[0]['value'].toString();
  }

  String labelTo(String user_data) {
    final dictUserData = json.decode(user_data);
    // final dictUserData2 = json.decode(dictUserData);
    final arrUserData = List<Map<String, dynamic>>.from(dictUserData);

    print(arrUserData[1]['label'].toString());

    return arrUserData[1]['label'].toString();
  }

  String valueTo(String user_data) {
    final dictUserData = json.decode(user_data);
    // final dictUserData2 = json.decode(dictUserData);
    final arrUserData = List<Map<String, dynamic>>.from(dictUserData);

    // print(arrUserData[0]['label'].toString());
    // print(arrUserData[0]['value'].toString());

    return arrUserData[1]['value'].toString();
  }

  deleteTransportDialog(BuildContext context, int index) {
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

        final transportationTripID = arrTransportsList[index]['id'].toString();

        deleteTransport(transportationTripID);
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

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteTransport(String transportationTripID) async {
    final response = await transportDeleteAPI(transportationTripID);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      dictBody['message'].toString().showSuccess();
      transportList();
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

  Future<http.Response> transportDeleteAPI(String transportationTripID) async {
    showLoaderGetX();
    final response = await API.instance.delete(
        endPoint:
            'trip/${tripID}/transport-list/${transportationTripID}/delete',
        // endPoint: 'trip/${tripID}/transport-list/${transportID}',
        params: {},
        isHeader: true);
    hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  tripCalculations() async {
    final response = await tripCalculationsAPI('23');
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);

      final dictTrip = Map<String, dynamic>.from(dictData['trip']);
      final dictCalculation =
          Map<String, dynamic>.from(dictTrip['calculation']);
      // totalEmission.value = dictCalculation['total_emission'].toString();

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

  Future<http.Response> tripCalculationsAPI(String tripID) async {
    // showLoaderGetX();
    final response = await API.instance
        .get(endPoint: 'trip/${tripID}/calculations', isHeader: true);
    // hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
