import 'dart:io';

import 'package:http/http.dart' as http;

import '../ExportFiles/ExportFilesMust.dart';

class ProfileController extends GetxController {
  Rx<File> image = File('').obs;
  RxString profilePicture = ''.obs;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  Rx<TextEditingController> passwordOld = TextEditingController().obs;
  Rx<TextEditingController> passwordNew = TextEditingController().obs;
  Rx<TextEditingController> passwordConfirm = TextEditingController().obs;

  Rx<TextEditingController> cardHolderName = TextEditingController().obs;
  Rx<TextEditingController> cardNumber = TextEditingController().obs;
  Rx<TextEditingController> expiryDate = TextEditingController().obs;
  Rx<TextEditingController> cardCode = TextEditingController().obs;

  RxList<bool> arrSelected = [false].obs;

  RxBool isLoadingProfile = false.obs;
  RxBool isLoadingChangePassword = false.obs;
  RxBool isLoadingPaymentMethod = false.obs;

  Map<String, dynamic> dictDataProfile = {};
  Map<String, dynamic> dictDataPaymentMethod = {};
  Map<String, dynamic> dictDataPaymentMethodData = {};

  initStateCustom() async {
    arrSelected.value = [];

    for (int i = 0; i < 4; i++) {
      arrSelected.add(false);
    }

    firstName.text = '';
    lastName.text = '';
    email.text = '';
    phone.text = '';

    getProfile();

    final dictDataPayment = await getPaymentMethodDetails();
    dictDataPaymentMethodData = dictDataPayment!;
  }

  setProfileData() {
    firstName.text = dictDataProfile['first_name'] ?? '';
    lastName.text = dictDataProfile['last_name'] ?? '';
    email.text = dictDataProfile['email'] ?? '';
    phone.text = dictDataProfile['mobile'] ?? '';
  }

  getProfile() async {
    final response = await getProfileAPI();
    dictDataProfile = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      setProfileData();
      avatar.value = dictDataProfile['avatar'] ?? '';
      profilePicture.value = avatar.value;

      print(profilePicture.value);
    } else {
      if (dictDataProfile['data'] != null) {
        final dictData = Map<String, dynamic>.from(dictDataProfile['data']);
        // final arrData = List<String>.from(dictData['email']);
        final arrData = List<String>.from(dictData[dictData.keys.first]);
        arrData.first.showError();
      } else if (dictDataProfile['message'] != null) {
        dictDataProfile['message'].toString().showError();
      }
    }
  }

  Future<http.Response> getProfileAPI() async {
    // showLoaderGetX();
    final response =
        await API.instance.get(endPoint: APIEndPoints.kUser, isHeader: true);
    // hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  updateProfileButton() async {
    final paramsBody = {
      'first_name': firstName.text,
      'last_name': lastName.text,
      'email': email.text,
      'mobile': phone.text,
      'gender': '',
      'date_of_birth': '',
      'address': '',
    };

    debugPrint(paramsBody.toString());

    final response = await updateProfile(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      dictBody['message'].toString().showSuccess();

      final dictData = Map<String, dynamic>.from(dictBody['data']);
      final dictUser = Map<String, dynamic>.from(dictData['user']);

      final avatarData = dictUser['avatar'] ?? '';

      avatar.value = avatarData;
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

  Future<http.Response> updateProfile(Map<String, dynamic> paramsBody) async {
    isLoadingProfile.value = true;
    final response = await API.instance.postImage(
        endPoint: APIEndPoints.kProfileUpdate,
        params: paramsBody,
        fileParams: 'avatar',
        file: image.value);
    isLoadingProfile.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  saveChangePasswordButton(BuildContext context) async {
    final paramsBody = {
      'old_password': passwordOld.value.text,
      'password': passwordNew.value.text,
      'confirm_password': passwordConfirm.value.text
    };

    debugPrint(paramsBody.toString());

    final response = await changePasswordAPI(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      passwordOld.value.text = '';
      passwordNew.value.text = '';
      passwordConfirm.value.text = '';

      dictBody['message'].toString().showSuccess();
      logOut(context);
      return true;
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

  Future<http.Response> changePasswordAPI(
      Map<String, dynamic> paramsBody) async {
    isLoadingChangePassword.value = true;
    final response = await API.instance.post(
        endPoint: APIEndPoints.kChangePassword,
        params: paramsBody,
        isHeader: true);
    isLoadingChangePassword.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  setPaymentMethodData() {
    if (dictDataPaymentMethodData['paymentMethod'] != null) {
      cardHolderName.value.text =
          dictDataPaymentMethodData['paymentMethod']['card_holder'] ?? '';
      expiryDate.value.text =
          dictDataPaymentMethodData['paymentMethod']['expiry'] ?? '';
      cardCode.value.text =
          dictDataPaymentMethodData['paymentMethod']['card_code'] ?? '';

      // cardNumber.value.text =
      //     dictDataPaymentMethodData['paymentMethod']['card_number'] ?? '';

      String card_number =
          dictDataPaymentMethodData['paymentMethod']['card_number'] ?? '';

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
  }

  Future<Map<String, dynamic>?> getPaymentMethodDetails() async {
    final response = await getPaymentMethodDetailsAPI();
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      // dictDataPaymentMethodData =
      //     Map<String, dynamic>.from(dictDataPaymentMethod['data']);
      // setPaymentMethodData();

      final dictData = Map<String, dynamic>.from(dictBody['data']);

      return dictData;
    } else {
      if (dictBody['data'] != null) {
        final dictData = Map<String, dynamic>.from(dictBody['data']);
        // final arrData = List<String>.from(dictData['email']);
        final arrData = List<String>.from(dictData[dictData.keys.first]);
        arrData.first.showError();
      } else if (dictBody['message'] != null) {
        dictBody['message'].toString().showError();
      }

      return null;
    }
  }

  Future<http.Response> getPaymentMethodDetailsAPI() async {
    // showLoaderGetX();
    final response = await API.instance
        .get(endPoint: APIEndPoints.kPaymentMethodSave, isHeader: true);
    // hideLoader();

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }

  savePaymentMethodButton(BuildContext context) async {
    final paramsBody = {
      'card_holder': cardHolderName.value.text,
      'card_number': cardNumber.value.text.removeAllWhitespace,
      'expiry': expiryDate.value.text,
      'card_code': cardCode.value.text,
    };

    debugPrint(paramsBody.toString());
    final response = await savePaymentMethodAPI(paramsBody);
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      dictBody['message'].toString().showSuccess();
      //  Navigator.pop(context);
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

  Future<http.Response> savePaymentMethodAPI(
      Map<String, dynamic> paramsBody) async {
    isLoadingPaymentMethod.value = true;
    final response = await API.instance.post(
      endPoint: APIEndPoints.kPaymentMethodStore,
      params: paramsBody,
      isHeader: true,
    );
    isLoadingPaymentMethod.value = false;

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  }
}
