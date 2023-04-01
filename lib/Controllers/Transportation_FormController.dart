import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:notification_center/notification_center.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

class Transportation_FormController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingFetch = false.obs;

  RxList<Map<String, dynamic>> arrTransformData = <Map<String, dynamic>>[].obs;
  List<TextEditingController> arrTextEditingController = [];
  List<String> arrValuesContainerSelected = [];
  String transportID = '';

  initCustom() {
    arrTransformData.clear();
    arrTextEditingController.clear();
    arrValuesContainerSelected.clear();
    
    transportForm();
  }

  transportForm() async {
    final response = await transportFormAPI();

    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    debugPrint("dictBody.. $dictBody");
    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);
      final dictTransportForm =
          Map<String, dynamic>.from(dictData['transportForm']);

      debugPrint(dictTransportForm.toString());

      // final arrFormData = jsonEncode(dictTransportForm['form_data']);

      final arrFormData = List<Map<String, dynamic>>.from(
          jsonDecode(dictTransportForm['form_data'].toString()));

      debugPrint(arrFormData.toString());

      // final arrFormData =
      //     List<Map<String, dynamic>>.from(dictTransportForm['form_data']);

      arrTransformData.value = arrFormData;

      debugPrint(arrTransformData.toString());
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

  Future<http.Response> transportFormAPI() async {
    final endPoints = 'transport-form?transport=${transportID}';

    isLoadingFetch.value = true;

    final response =
        await API.instance.get(endPoint: endPoints, isHeader: true);

    isLoadingFetch.value = false;

    update();
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  saveButton(String tripID, {String? transportationTripID}) async {
    List<Map<String, dynamic>> arrFormData = [];
    for (int i = 0; i < arrTransformData.length; i++) {
      Map<String, dynamic> dictTransformData = arrTransformData[i];

      dictTransformData['value'] = arrValuesContainerSelected[i].isNotEmpty ? arrValuesContainerSelected[i] : arrTextEditingController[i].text;

      arrFormData.add(dictTransformData);
    }

    debugPrint(" fromData.... ${arrFormData.toString()}");



    final jsonString = jsonEncode(arrFormData);

    final paramsBody = {
      "transport_id": transportID,
      "form_data": arrFormData,
    };


    http.Response response;

    if (transportationTripID == null) {
      response = await transportFormSaveAPI(paramsBody, tripID);
    } else {
      response = await transportFormUpdateAPI(
          paramsBody, tripID, transportationTripID);
    }

    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      Get.back();

      // dictBody['message'].toString().showSuccess();

      final dictData = Map<String, dynamic>.from(dictBody['data']);
      final total_co2 = dictData['total_co2'].toString();
      dictData['total_co2'].toString().showSuccess();

      NotificationCenter().notify(
        'total_co2', data: total_co2
      );

      NotificationCenter().notify(
        'transportList',
      );
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

  Future<http.Response> transportFormSaveAPI(
      Map<String, dynamic> paramsBody, String tripID) async {
    isLoading.value = true;

    log(paramsBody.toString());

    log(jsonEncode(paramsBody));

    final response = await API.instance.postStringBodyParams(
        endPoint: 'trip/${tripID}/transport-form/save',
        params: jsonEncode(paramsBody),
        isHeader: true);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  Future<http.Response> transportFormUpdateAPI(Map<String, dynamic> paramsBody,
      String tripID, String transportationTripID) async {
    isLoading.value = true;
    final response = await API.instance.postStringBodyParams(
        endPoint:
            'trip/${tripID}/transport-form/save?id=${transportationTripID}',
        params: jsonEncode(paramsBody),
        isHeader: true);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
