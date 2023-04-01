import 'dart:developer';
import 'package:http/http.dart' as http;
import '../ExportFiles/ExportFilesMust.dart';

class BlogListingController extends GetxController {
  RxList tipsSuggestionsData = [].obs;
  RxMap blogDetails = {}.obs;
  RxBool isLoading = false.obs;
  RxInt idx = 0.obs;

  reset() {
    isLoading.value = false;
  }

  Future<void> getTipsSuggestionData() async {
    isLoading.value = true;
    final response = await API.instance
        .get(endPoint: APIEndPoints.kTipsSuggestions, isHeader: true);
    isLoading.value = false;

    log(response.statusCode.toString());
    log(response.body);

    // if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // if (data['status'] == " success") {
    tipsSuggestionsData.value = data['data']['blogs'];
    log('tipsSuggestiondata : ${tipsSuggestionsData.value}');
    // }
    // }

    // return response;
  }

  Future<void> getBlogDetails(blogId) async {
    isLoading.value = true;
    final response = await API.instance
        .get(endPoint: '${APIEndPoints.kBlogDetails}$blogId', isHeader: true);
    isLoading.value = false;

    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      idx.value = blogId;
      if (data['status'] == "success") {
        blogDetails.value = data['data']['blog'];
        log('blogDetails : ${blogDetails.value}');
      }
    }

    // return response;
  }
}
