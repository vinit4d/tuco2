import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

class API {
  API._privateConstructor();

  static final API instance = API._privateConstructor();

  // final kBaseURL = 'https://tuco2.addwebprojects.com/api/';

  String get kBaseImage {
    if (kDebugMode) {
      print('debug mode');
      return 'https://tuco2.addwebprojects.com/';
    } else {
      print('live mode');
      return 'live URL';
    }
  }

  String get kBaseURL {
    if (kDebugMode) {
      print('debug mode');
      return 'https://tuco2.addwebprojects.com/api/';
    } else {
      print('live mode');
      return 'live URL';
    }
  }

  String internetConnectPoorBody = 'Internet connection is poor.';
  int internetConnectPoorCode = 1111;

  int apiExceptionCode = 1112;

  Future<bool> _checkInternet() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        debugPrint('Mobile data is connected');
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        debugPrint('WiFi connected');
        return true;
      } else {
        debugPrint('Internet is not connected');
        'Internet is not connected'.showError();
        return false;
      }
    } catch (error) {
      debugPrint(error.toString());
      error.toString().showError();
      return false;
    }
  }

  checkInternetSlow(http.Response response) {
    Future.delayed(const Duration(seconds: 1), () {
      if (response.statusCode == 1111) {
        response.body.toString().showError();
      }
    });
  }

  Future<http.Response> get(
      {required String endPoint, bool isHeader = false}) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse(kBaseURL + endPoint);
    print(url);

    Map<String, String> header = {};
    if (isHeader) {
      header = {
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
        'Authorization': 'Bearer ${dictData['token']}',
      };
    }

    try {
      final response = await http.get(url, headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return http.Response(
              internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      checkInternetSlow(response);

      return response;
    } catch (error) {
      debugPrint('Error is:-' + error.toString());

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> delete(
      {required String endPoint,
      required Map<String, dynamic> params,
      bool isHeader = false}) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse(kBaseURL + endPoint);
    print(url);

    Map<String, String> header = {};
    if (isHeader) {
      header = {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dictData['token']}',
      };
    }

    try {
      final response =
          await http.delete(url, headers: header, body: params).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return http.Response(
              internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      checkInternetSlow(response);

      return response;
    } catch (error) {
      debugPrint('Error is:-' + error.toString());

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> post(
      {required String endPoint,
      required Map<String, dynamic> params,
      bool isHeader = false}) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse(kBaseURL + endPoint);
    print(url);

    Map<String, String> header = {};
    if (isHeader) {
      header = {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${dictData['token']}',
      };
    }

    try {
      final response =
          await http.post(url, body: params, headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return http.Response(
              internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      checkInternetSlow(response);

      return response;
    } catch (error) {
      debugPrint('Error is:-' + error.toString());

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> postStringBodyParams(
      {required String endPoint,
      required String params,
      bool isHeader = false}) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse(kBaseURL + endPoint);
    print(url);

    Map<String, String> header = {};
    if (isHeader) {
      header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${dictData['token']}',
      };
    }

    try {
      final response =
          await http.post(url, body: params, headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return http.Response(
              internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      checkInternetSlow(response);

      return response;
    } catch (error) {
      debugPrint('Error is:-' + error.toString());

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> postImage({
    required String endPoint,
    required Map<String, dynamic> params,
    required String fileParams,
    required File? file,
  }) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse('$kBaseURL$endPoint');
    final request = http.MultipartRequest('POST', url);

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = 'Bearer ${dictData['token']}';

    params.forEach((key, value) {
      request.fields[key] = value;
    });

    try {
      if (file!.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath(fileParams, file.path));
      }
      final response = await request.send();

      final res = await http.Response.fromStream(response).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response('Internet connection is poor.', 1111);
        },
      );
      print(res.body);

      return res;
    } catch (error) {
      debugPrint('Error is:-' + error.toString());
      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }
}

class APIEndPoints {
  static const kLogin = 'login';
  static const kRegister = 'register';
  static const kForgotPassword = 'forgot-password';
  static const kVerifyOTP = 'verify-otp';
  static const kResetPassword = 'reset-password';
  static const kUser = 'user';
  static const kProfileUpdate = 'profile-update';
  static const kChangePassword = 'change-password';
  static const kTransports = 'transports';
  static const kCreateTrip = 'create-trip';
  static const kViewProjects = 'view-projects';

  static const kBillingDetailsSave = 'billing-details/save';
  static const kTipsSuggestions = 'tips-suggestions';
  static const kBlogDetails = 'tip-suggestion/details?blog=';

  static const kContactUs = 'contact/query/save';
  static const kGetBillingDetail = 'billing-details/save?id=';
  static const kViewPages = 'view-pages';
  static const kPageDetails = 'page/details?page=';
  static const kPaymentMethodStore = 'payment-method/store';
  static const kPaymentMethodSave = 'payment-method/show';

  static const kFaqs = 'faq/list';
}
