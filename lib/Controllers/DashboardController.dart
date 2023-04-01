import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tuco2/Styles/ColorStyle.dart';
import 'package:tuco2/Utils/API.dart';
import 'package:tuco2/Utils/Global.dart';

import '../Models/ChartData.dart';

class DashboardController extends GetxController {
  Rx<File> image = File('').obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingFetch = false.obs;

  RxInt totalEmissions = 0.obs;
  RxInt totalPersons = 0.obs;
  RxDouble totalEmissionsPerPerson = 0.0.obs;
  RxInt carbonOffset = 0.obs;
  RxDouble carbonOffsetPercent = 0.0.obs;
  RxDouble globalAverageEmissions = 0.0.obs;
  RxList<ChartData> arrCO2Emissions = <ChartData>[].obs;
  RxList<ChartData> chartDataCarbonOffset = <ChartData>[].obs;
  RxList<Map<String, dynamic>> arrTransports = <Map<String, dynamic>>[].obs;
  RxList<ChartData> arrCO2EmissionIntensity = <ChartData>[].obs;

  initMethod() {
    DashboardResponse();

    //
    totalEmissions.value = 0;
  }

  DashboardResponse() async {
    final response = await DashboardAPI();
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);
      // final dictDashboardData =
      //     Map<String, dynamic>.from(dictData['Dashboard']);

      debugPrint(dictData.toString());

      totalEmissions.value = dictData['totalEmissions'] ?? 0;
      totalPersons.value = dictData['totalPersons'] ?? 0;
      totalEmissionsPerPerson.value =
          dictData['totalEmissionsPerPerson'] ?? 0.0;
      carbonOffset.value = dictData['carbonOffset'] ?? 0;
      carbonOffsetPercent.value = dictData['carbonOffsetPercent'] ?? 0;
      globalAverageEmissions.value = dictData['globalAverageEmissions'] ?? 0.0;

      arrTransports.value =
          List<Map<String, dynamic>>.from(dictData['transports']);

      chartDataCarbonOffset.add(ChartData('carbonOffset',
          double.parse(carbonOffset.toString()), ColorStyle.greenColor_52BC7F));

      chartDataCarbonOffset.add(ChartData(
          'carbonOffsetPercent',
          double.parse(carbonOffsetPercent.toString()),
          ColorStyle.greenColor_52BC7F));

      arrCO2EmissionIntensity.add(ChartData(
          'globalAverageEmissions',
          double.parse(globalAverageEmissions.toString()),
          ColorStyle.greenColor_52BC7F));

      arrCO2EmissionIntensity.add(ChartData(
          'totalEmissionsPerPerson',
          double.parse(totalEmissionsPerPerson.toString()),
          ColorStyle.yellowColor_0FDC530));

      for (int i = 0; i < arrTransports.length; i++) {
        debugPrint(arrTransports[i]['percentage'].toString());
        arrCO2Emissions.add(ChartData(
            arrTransports[i]['transport_type'].toString(),
            double.parse(arrTransports[i]['percentage'].toString()),
            ColorStyle.greenColor_52BC7F));
      }
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

  Future<http.Response> DashboardAPI() async {
    final endPoints = 'dashboard';

    isLoadingFetch.value = true;

    final response =
        await API.instance.get(endPoint: endPoints, isHeader: true);

    isLoadingFetch.value = false;

    update();
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
