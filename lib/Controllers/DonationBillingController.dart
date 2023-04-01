import 'package:http/http.dart' as http;
import 'package:tuco2/Controllers/ProfileController.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

class DonationBillingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingBillingData = false.obs;

  RxBool isCoupon = false.obs;

  String price = '';
  String projectID = '';

  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> countryRegion = TextEditingController().obs;
  Rx<TextEditingController> state = TextEditingController().obs;

  Rx<TextEditingController> townCity = TextEditingController().obs;
  Rx<TextEditingController> streetAddress = TextEditingController().obs;
  Rx<TextEditingController> postCodeZip = TextEditingController().obs;

  Rx<TextEditingController> cardHolderName = TextEditingController().obs;
  Rx<TextEditingController> cardNumber = TextEditingController().obs;
  Rx<TextEditingController> expiryDate = TextEditingController().obs;
  Rx<TextEditingController> cardCodeCVV = TextEditingController().obs;

  RxBool isUpdate = false.obs;

  Map<String, dynamic> dictBillingDetails = {};

  RxInt billingID = 0.obs;

  initCustom() async {
    isLoading.value = false;
    isCoupon.value = false;
    isLoadingBillingData.value = false;

    final controllerProfile = ProfileController();

    showLoaderGetX();
    final dictDataPayment = await controllerProfile.getPaymentMethodDetails();
    hideLoader();
    setDataPayment(dictDataPayment!);

    // getBillingDetail('3');
  }

  isCouponMethod() {
    isCoupon.value = !isCoupon.value;
  }

  setDataPayment(Map<String, dynamic> dictDataPayment) {
    // Payment details
    cardHolderName.value.text =
        dictDataPayment['paymentMethod']['card_holder'] ?? '';
    expiryDate.value.text = dictDataPayment['paymentMethod']['expiry'] ?? '';
    cardCodeCVV.value.text =
        dictDataPayment['paymentMethod']['card_code'] ?? '';

    // cardNumber.value.text = dictBillingDetails['card_number'] ?? '';
    String card_number =
        dictDataPayment['paymentMethod']['card_number'].toString() ?? '';

    List<String> arrCardNumber = [];

    for (int i = 0; i < card_number.length; i++) {
      if (i == 4) {
        arrCardNumber.add(' ${card_number[i]}');
      } else if (i == 8) {
        arrCardNumber.add(' ${card_number[i]}');
      } else if (i == 12) {
        arrCardNumber.add(' ${card_number[i]}');
      } else {
        arrCardNumber.add(card_number[i]);
      }
    }

    final stringCardNumber = arrCardNumber.join("");

    cardNumber.value.text = stringCardNumber;
  }

  setData() {
    billingID.value = dictBillingDetails['id'] ?? 0;

    firstName.value.text = dictBillingDetails['first_name'] ?? '';
    lastName.value.text = dictBillingDetails['last_name'] ?? '';
    countryRegion.value.text = dictBillingDetails['country'] ?? '';
    state.value.text = dictBillingDetails['state'] ?? '';
    townCity.value.text = dictBillingDetails['city'] ?? '';
    streetAddress.value.text = dictBillingDetails['street'] ?? '';
    postCodeZip.value.text = dictBillingDetails['zip'] ?? '';
  }

  submitOffSetButton(context) async {
    final paramsBody = {
      "trip_id": tripID,
      "project_id": projectID,
      "first_name": firstName.value.text,
      "last_name": lastName.value.text,
      "country": countryRegion.value.text,
      "state": state.value.text,
      "city": townCity.value.text,
      "street": streetAddress.value.text,
      "zip": postCodeZip.value.text,
      // Payment details
      "amount": price,
      "card_holder": cardHolderName.value.text,
      "card_number": cardNumber.value.text.removeAllWhitespace,
      "expiry": expiryDate.value.text,
      "card_code": cardCodeCVV.value.text,
      "payment_status": "success"
    };

    print(paramsBody);

    http.Response response;

    if (billingID.value == 0) {
      response = await billingDetailSaveAPI(paramsBody);
    } else {
      response =
          await billingDetailUpdateAPI(paramsBody, billingID.value.toString());
    }

    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      dictBody['message'].toString().showSuccess();

      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      if (dictBody['data'] != null) {
        final dictData = Map<String, dynamic>.from(dictBody['data']);
        final arrData = List<String>.from(dictData[dictData.keys.first]);
        arrData.first.showError();
      } else if (dictBody['message'] != null) {
        dictBody['message'].toString().showError();
      }
    }
  }

  Future<http.Response> billingDetailSaveAPI(
      Map<String, dynamic> paramsBody) async {
    isLoading.value = true;
    final response = await API.instance.post(
        endPoint: APIEndPoints.kBillingDetailsSave,
        params: paramsBody,
        isHeader: true);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  Future<http.Response> billingDetailUpdateAPI(
      Map<String, dynamic> paramsBody, String id) async {
    isLoading.value = true;
    final response = await API.instance.post(
        endPoint: "${APIEndPoints.kBillingDetailsSave}?id=${id}",
        params: paramsBody,
        isHeader: true);
    isLoading.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  Future<http.Response> getBillingDetailAPI(String id) async {
    isLoadingBillingData.value = true;
    showLoaderGetX();
    final response = await API.instance.post(
        endPoint: "${APIEndPoints.kBillingDetailsSave}?id=${id}&show",
        params: {},
        isHeader: true);
    hideLoader();
    isLoadingBillingData.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  getBillingDetail(String id) async {
    print(id);
    final response = await getBillingDetailAPI(id);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      if (dictBody['data'] == null) {
        isUpdate.value = false;
      } else {
        isUpdate.value = true;

        final dictData = Map<String, dynamic>.from(dictBody['data']);

        dictBillingDetails =
            Map<String, dynamic>.from(dictData['billingDetails']);
        setData();
      }
    } else {
      if (dictBody['data'] != null) {
        final dictData = Map<String, dynamic>.from(dictBody['data']);
        final arrData = List<String>.from(dictData[dictData.keys.first]);
        arrData.first.showError();
      } else if (dictBody['message'] != null) {
        dictBody['message'].toString().showError();
      }
    }
  }
}
