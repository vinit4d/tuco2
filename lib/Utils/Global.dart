import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Views/Login.dart';

loader() {
  return Center(
    child: Container(
      height: 60,
      margin: const EdgeInsets.only(left: 40, right: 40),
      decoration: BoxDecoration(
          color: ColorStyle.primaryColor_52BC7F,
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  const SizedBox(
          //   height: 30,
          //   width: 30,
          //   child: CircularProgressIndicator(
          //     strokeWidth: 3,
          //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //   ),
          // ),
          const SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
          Container(
            width: 16,
          ),
          Text("Loading ...",
              style: TextStylesCustom.textStyles_16
                  .apply(color: Colors.white, fontWeightDelta: 2)),
        ],
      ),
    ),
  );
}

showLoaderGetX() {
  Get.dialog(
    Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: 60,
          margin: const EdgeInsets.only(left: 40, right: 40),
          decoration: BoxDecoration(
              color: ColorStyle.primaryColor_52BC7F,
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  const SizedBox(
              //   height: 30,
              //   width: 30,
              //   child: CircularProgressIndicator(
              //     strokeWidth: 3,
              //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //   ),
              // ),
              const SpinKitCircle(
                color: Colors.white,
                size: 50.0,
              ),
              Container(
                width: 16,
              ),
              Text("Loading ...",
                  style: TextStylesCustom.textStyles_16
                      .apply(color: Colors.white, fontWeightDelta: 2)),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

hideLoader() {
  Navigator.pop(Get.context!);
}

extension StringCustom on String {
  showError() {
    // if (Get.isSnackbarOpen) {
    //   Get.closeAllSnackbars();
    //   // Get.closeCurrentSnackbar();
    // }

    Get.closeAllSnackbars();

    // Get.closeCurrentSnackbar();

    Get.snackbar(
      "Sorry!",
      this,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  showSuccess() {
    // if (Get.isSnackbarOpen) {
    //   Get.closeAllSnackbars();
    //   // Get.closeCurrentSnackbar();
    // }

    Get.closeAllSnackbars();
    // Get.closeCurrentSnackbar();

    Get.snackbar(
      "Success!",
      this,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  saveGetStorage({required String key}) {
    final storage = GetStorage();
    storage.write(key, this);
  }

  stringUnscape() {
    return Bidi.stripHtmlIfNeeded(this);
  }
}

goToAnotherScreen(Widget page) {
  GetPage(
    name: "/second",
    page: () => page,
    transition: Transition.rightToLeft,
    transitionDuration: Duration(milliseconds: 400),
    curve: Curves.fastOutSlowIn,
  );
}

navigateMultiBottom(context, Widget child) {
  // For more info Push like iPhone type visit below links:-
  // https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823
  // https://github.com/divyanshub024/Flutter-route-transition

  // Navigator.of(context, rootNavigator: true).push(
  //     MaterialPageRoute(builder: (context) => child, maintainState: true));

  Navigator.of(context, rootNavigator: false).push(
    CupertinoPageRoute(
        // fullscreenDialog: true,
        builder: (context) => child,
        maintainState: false),
  );

  // Navigator.push(
  //   context,
  //   PageRouteBuilder(
  //     pageBuilder: (_, __, ___) => child,
  //     transitionDuration: Duration(milliseconds: 400),
  //     transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
  //   ),
  // );

  // Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (BuildContext context) => child
  //     )
  // );
}

logOut(BuildContext context) {
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
      "Log Out",
      style: TextStylesCustom.textStyles_18
          .apply(color: Colors.red, fontWeightDelta: 2),
    ),
    onPressed: () async {
      Scaffold.of(context).closeDrawer();

      Get.back();

      final storage = GetStorage();
      storage.remove('user');

      Get.offAll(Login());
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

Future<void> urlLauncher(String url) async {
  final Uri _url = Uri.parse(url);

  if (!await launchUrl(
    _url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $_url';
  }
}

extension MapCustom on Map {
  userSaved() {
    final getStorage = GetStorage();
    getStorage.write('user', jsonEncode(this));
  }
}

String chnageDateFormat(String date) {
  //2023-04-03
  DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('MM/dd/yyyy');
  var outputDate = outputFormat.format(inputDate);
  print(outputDate);
  return outputDate;
}
