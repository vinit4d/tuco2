import 'dart:developer';

import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';

class FrequentlyAskedQuestionController extends GetxController {
  RxInt selected = 0.obs;
  RxList faqs = [].obs;
  RxBool isLoading = false.obs;

  Future<void> initFunction() async {
    selected.value = 1;
    await getFaqs();
  }

  reset() {
    isLoading.value = false;
    faqs.value = [];
  }

  Future<void> getFaqs() async {
    isLoading.value = true;
    final response = await API.instance
        .get(endPoint: APIEndPoints.kFaqs, isHeader: true);
    isLoading.value = false;

    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == "success") {
    faqs.value = data['data']['faq'];
    log('faqs : ${faqs.value}');
    }
    }

    // return response;
  }

  }
