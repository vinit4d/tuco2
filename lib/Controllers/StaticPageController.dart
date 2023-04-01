import 'dart:developer';

import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';

class StaticPageController extends GetxController {
  RxList staticPages = [].obs;
  RxMap pageDetails = {}.obs;
  RxList media = [].obs;
  RxBool isLoading = false.obs;

  Future<void> initFunction(pageName) async {
    await getStaticPageId();
    await getPageDetails(pageName);
  }

  reset() {
    isLoading.value = false;
    staticPages.value = [];
    pageDetails.value = {};
    media.value = [];
  }

  Future<void> getStaticPageId() async {
    isLoading.value = true;
    final response = await API.instance
        .get(endPoint: APIEndPoints.kViewPages, isHeader: true);
    isLoading.value = false;

    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == "success") {
    staticPages.value = data['data']['pages'];
    log('staticPages : ${staticPages.value}');
    }
    }

    // return response;
  }

  Future<void> getPageDetails(pageName) async {
    var page = staticPages.firstWhere((element) => element['name'] == pageName);
    if (page != null) {
      isLoading.value = true;
      final response = await API.instance.get(
          endPoint: '${APIEndPoints.kPageDetails}${page["id"]}',
          isHeader: true);
      isLoading.value = false;

      log(response.statusCode.toString());
      log(response.body);

      // if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // if (data['status'] == " success") {
      pageDetails.value = data['data']['page'];
      if (pageDetails['imgs_videos'] != null) {
        media.value = jsonDecode(pageDetails['imgs_videos']);
      }else{
        media.value = [];
      }
      log('pageDetails : ${pageDetails.value}');
    } else {
      log("page not found");
    }
    // }
    // }

    // return response;
  }
}
