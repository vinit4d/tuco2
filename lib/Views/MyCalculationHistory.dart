import 'package:dotted_line/dotted_line.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

import '../Components/Text.dart';
import '../Controllers/MyCalculationHistoryController.dart';
import 'CalculationHistoryDetail.dart';

class MyCalculationHistoryScreen extends StatelessWidget {
  MyCalculationHistoryScreen({super.key});

  final controller = Get.put(MyCalculationHistoryController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyCalculationHistoryController(),
      initState: (_) {
        Future.delayed(const Duration(milliseconds: 200), () {
          controller.initMethod();
        });
      },
      builder: (controller) {
        return Scaffold(
            body: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: HeadingText("My calculation history")),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: controller.arrTrips.length > 0
                    ? ListView.separated(
                        itemCount: controller.arrTrips.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                navigateMultiBottom(
                                    context,
                                    MyCalculationHistoryDetailScreen(
                                        controller.arrTrips[index]['id']));
                              },
                              child: listTile(controller.arrTrips, index));
                        },
                      )
                    : Center(
                        child: BoldText(
                            "No Data Found", ColorStyle.greyColor_606060),
                      ),
              )
            ],
          ),
        ));
      },
    );
  }
}

Widget listTile(RxList<Map<String, dynamic>> arrTrips, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    child: Container(
      decoration: BoxDecoration(
          color: ColorStyle.lightGreenColor_52BC7F,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldText(
                    chnageDateFormat(arrTrips[index]['start_date'].toString()),
                    ColorStyle.greyColor_606060),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 2),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                ImageStyle.location,
                height: 24,
                width: 24,
              ),
              normalText(arrTrips[index]['from'].toString()),
              SizedBox(
                width: 2,
              ),
              SizedBox(
                width: 20,
                height: 5,
                child: DottedLine(
                  direction: Axis.horizontal,
                  // lineLength: double.infinity,
                  lineThickness: 1,
                  dashLength: 3.0,
                  dashColor: ColorStyle.greyColor_0A09F99,
                  // dashGradient: [Colors.red, Colors.blue],
                  dashRadius: 70.0,
                  dashGapLength: 2.0,
                  // dashGapColor: Colors.transparent,
                  // dashGapGradient: [Colors.red, Colors.blue],
                  dashGapRadius: 4.0,
                ),
              ),
              Image.asset(
                ImageStyle.arrowDestinationIcon,
                height: 24,
                width: 24,
              ),
              SizedBox(
                width: 2,
              ),
              SizedBox(
                width: 20,
                height: 5,
                child: DottedLine(
                  direction: Axis.horizontal,
                  // lineLength: double.infinity,
                  lineThickness: 1,
                  dashLength: 3.0,
                  dashColor: ColorStyle.greyColor_0A09F99,
                  // dashGradient: [Colors.red, Colors.blue],
                  dashRadius: 0.0,
                  dashGapLength: 2.0,
                  // dashGapColor: Colors.transparent,
                  // dashGapGradient: [Colors.red, Colors.blue],
                  dashGapRadius: 4.0,
                ),
              ),
              Image.asset(
                ImageStyle.location,
                height: 24,
                width: 24,
              ),
              Flexible(child: normalText(arrTrips[index]['to'].toString())),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                normalText('Trip days: '),
                boldText12(arrTrips[index]['trip_days'].toString()),
                SizedBox(
                  width: 10,
                ),
                normalText('People: '),
                boldText12(arrTrips[index]['peoples'].toString()),
                SizedBox(
                  width: 10,
                ),
                normalText('Total estimation: '),
                Flexible(
                    child: boldText12(arrTrips[index]['calculation']
                            ['total_emission']
                        .toString())),
              ],
            ),
          ),
        ]),
      ),
    ),
  );
}
