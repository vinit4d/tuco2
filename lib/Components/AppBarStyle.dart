import 'package:http/http.dart' as http;
import 'package:notification_center/notification_center.dart';

import '../ExportFiles/ExportFilesMust.dart';

class AppBarStyle extends StatelessWidget implements PreferredSizeWidget {
  final bool? isTrailing;

  AppBarStyle({
    Key? key,
   required this.isTrailing   // = false,
  }) : super(key: key);

  double heightAppBar = 54;

  @override
  Size get preferredSize => Size.fromHeight(heightAppBar);

  final controller = Get.put(AppBarStyleController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AppBarStyleController(),
        // initState: (_) {
        //   Future.delayed(const Duration(seconds: 1), () {
        //     controller.initCustom();
        //   },
        //   );
        // },
        builder: (_) {
          return PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 30,
                    padding: const EdgeInsets.only(),
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      child: Image.asset(
                        ImageStyle.menu,
                        height: 24,
                        width: 24,
                      ),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  Image.asset(
                    ImageStyle.logoWithNamePNG,
                    // width: 80,
                    height: 30,
                  ),
                  // if (isTrailing!)
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 80,))
                    //   alignment: Alignment.center,
                    //   padding: const EdgeInsets.only(
                    //     left: 16,
                    //     right: 16,
                    //   ),
                    //   decoration: BoxDecoration(
                    //       color: ColorStyle.primaryColor_52BC7F,
                    //       borderRadius: BorderRadius.circular(8)),
                    //   child: Text(
                    //     '${controller.totalEmission.value} KG',
                    //     style: TextStylesCustom.textStyles_16
                    //         .apply(fontWeightDelta: 4, color: Colors.white),
                    //   ),
                    // ),
                    // onTap: () {
                    //   NotificationCenter().notify('navigateToCarbonFootPrint');
                    // },
                  // )
                  // else
                  //   const SizedBox(
                  //     height: 40,
                  //     width: 80,
                  //   ),
                ],
              ),
            ),
          );
        });
  }
}

class AppBarStyleController extends GetxController {
  RxString totalEmission = '0'.obs;

  initCustom() {
    tripCalculations();
  }

  tripCalculations() async {
    final response = await tripCalculationsAPI('23');
    final dictBody = Map<String, dynamic>.from(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final dictData = Map<String, dynamic>.from(dictBody['data']);

      final dictTrip = Map<String, dynamic>.from(dictData['trip']);
      final dictCalculation =
          Map<String, dynamic>.from(dictTrip['calculation']);
      totalEmission.value = dictCalculation['total_emission'].toString();

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
