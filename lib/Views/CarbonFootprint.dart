import 'package:dotted_line/dotted_line.dart';
import 'package:notification_center/notification_center.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tuco2/Controllers/CarbonFootprintController.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

import '../Models/ChartData.dart';
import 'Donation/DonationProjectListingScreen.dart';

// class ChartData {
//   ChartData(this.x, this.y, [this.color]);
//   final String x;
//   final double y;
//   final Color? color;
// }

class CarbonFootprint extends StatefulWidget {
  const CarbonFootprint({Key? key}) : super(key: key);

  @override
  State<CarbonFootprint> createState() => _CarbonFootprintState();
}

class _CarbonFootprintState extends State<CarbonFootprint> {
  // final List<ChartData> arrCodeIntensity = [
  //   ChartData('CHN', 80, ColorStyle.redColor_0F15222),
  //   ChartData('GER', 60, ColorStyle.blueSkyColor_61AFF6),
  // ];

  int rating = 40;

  TooltipBehavior _tooltip = TooltipBehavior(enable: false);

  @override
  void initState() {
    super.initState();
  }

  final controller = Get.put(CarbonFootprintController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 30,
          bottom: 30,
        ),
        child: GetBuilder(
          init: CarbonFootprintController(),
          initState: (_) {
            Future.delayed(const Duration(seconds: 1), () {
              controller.initCustom();
            });
          },
          builder: (_) {
            return Container(
              height: 1200,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Carbon footprint results",
                        style: TextStylesCustom.textStyles_24.apply(
                            fontWeightDelta: 3,
                            color: ColorStyle.greyColor_606060),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Breaking down CO2 emissions",
                        style: TextStylesCustom.textStyles_16.apply(
                            fontWeightDelta: 3,
                            color: ColorStyle.greyColor_606060),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          SfCircularChart(
                              margin: EdgeInsets.all(0),
                              // legend: Legend(
                              //     isVisible: true,
                              //     alignment: ChartAlignment.center,
                              //     position: LegendPosition.bottom,
                              //     padding: 0,
                              //     iconWidth: 0,
                              //     itemPadding: 0
                              //     // width: '0',
                              //     // height: '0'
                              //     ),
                              // tooltipBehavior: TooltipBehavior(enable: false),

                              palette: [
                                ColorStyle.blueSkyColor_61AFF6,
                                ColorStyle.yellowColor_0FDC530,
                                ColorStyle.redColor_0F15222,
                                ColorStyle.greyColor_0A09F99,
                                ColorStyle.blueColor_514899,
                                ColorStyle.primaryColor_52BC7F,
                              ],
                              // borderColor: Colors.red,
                              // borderWidth: 10,
                              // backgroundColor: Colors.yellow,
                              // centerX: '0%',
                              // centerY: '50%',

                              series: <CircularSeries>[
                                DoughnutSeries<ChartData, String>(
                                  dataSource: controller.arrCO2Emissions,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  radius: '116%',
                                  innerRadius: '60%',
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  startAngle: 270,
                                  endAngle: 90,
                                )
                              ]),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total CO2 footprint",
                          textAlign: TextAlign.center,
                          style: TextStylesCustom.textStyles_14.apply(
                              fontWeightDelta: 2,
                              color: ColorStyle.greyColor_606060),
                        ),
                        Text(
                          "${controller.totalEmission.value} KG",
                          textAlign: TextAlign.center,
                          style: TextStylesCustom.textStyles_34.apply(
                              fontWeightDelta: 8,
                              color: ColorStyle.redColor_0F15222),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 300,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.arrTransports.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.arrTransports[0]['transport_type']
                                        .toString() +
                                    ' - ' +
                                    controller.arrTransports[0]['percentage']
                                        .toString() +
                                    '%',
                                // "Airplane - " + '70%',
                                style: TextStylesCustom.textStyles_16.apply(
                                    fontWeightDelta: 4,
                                    color: ColorStyle.blueSkyColor_61AFF6),
                              ),
                              Text(
                                // "Train - " + '0%',
                                controller.arrTransports[1]['transport_type']
                                        .toString() +
                                    ' - ' +
                                    controller.arrTransports[1]['percentage']
                                        .toString() +
                                    '%',
                                style: TextStylesCustom.textStyles_16.apply(
                                    fontWeightDelta: 4,
                                    color: ColorStyle.yellowColor_0FDC530),
                              ),
                              Text(
                                // "Coach - " + '0%',
                                controller.arrTransports[2]['transport_type']
                                        .toString() +
                                    ' - ' +
                                    controller.arrTransports[2]['percentage']
                                        .toString() +
                                    '%',
                                style: TextStylesCustom.textStyles_16.apply(
                                    fontWeightDelta: 4,
                                    color: ColorStyle.redColor_0F15222),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (controller.arrTransports.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // "Boat - " + '0%',
                                controller.arrTransports[3]['transport_type']
                                        .toString() +
                                    ' - ' +
                                    controller.arrTransports[3]['percentage']
                                        .toString() +
                                    '%',
                                style: TextStylesCustom.textStyles_16.apply(
                                    fontWeightDelta: 4,
                                    color: ColorStyle.greyColor_0A09F99),
                              ),
                              Text(
                                // "Accommodation - " + '0%',
                                controller.arrTransports[4]['transport_type']
                                        .toString() +
                                    ' - ' +
                                    controller.arrTransports[4]['percentage']
                                        .toString() +
                                    '%',
                                style: TextStylesCustom.textStyles_16.apply(
                                    fontWeightDelta: 4,
                                    color: ColorStyle.blueColor_514899),
                              ),
                              Text(
                                // "Car - " + '0%',
                                controller.arrTransports[5]['transport_type']
                                        .toString() +
                                    ' - ' +
                                    controller.arrTransports[5]['percentage']
                                        .toString() +
                                    '%',
                                style: TextStylesCustom.textStyles_16.apply(
                                    fontWeightDelta: 4,
                                    color: ColorStyle.primaryColor_52BC7F),
                              ),
                            ],
                          ),

                        const SizedBox(
                          height: 40,
                        ),

                        //code

                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), //clipping the whole widget
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: ColorStyle.greyColor_0E6E6E6,
                                    width: 1)),
                            height: 120,
                            child: ListView.separated(
                              itemCount: controller.arrTransports.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  child: Image.asset(
                                    ImageStyle.line_Dotted,
                                    height: 100,
                                    width: 1,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorStyle.greenColor_52BC7F,
                                        // borderRadius: BorderRadius.only(
                                        //     topLeft: Radius.circular(6),
                                        //     topRight: Radius.circular(6)),
                                      ),
                                      height: 40,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Text(
                                        controller.arrTransports[index]
                                                ['transport_type']
                                            .toString(),
                                        style: TextStylesCustom.textStyles_14
                                            .apply(
                                                fontWeightDelta: 3,
                                                color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          controller.arrTransports[index]['kgs']
                                              .toString(),
                                          style: TextStylesCustom.textStyles_18
                                              .apply(
                                            fontWeightDelta: 3,
                                            color: ColorStyle.greyColor_606060,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "kg",
                                          style: TextStylesCustom.textStyles_18
                                              .apply(
                                            fontWeightDelta: 3,
                                            color: ColorStyle.greyColor_606060,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Carbon intensity",
                          style: TextStylesCustom.textStyles_24.apply(
                              fontWeightDelta: 3,
                              color: ColorStyle.greyColor_606060),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Comparison of C02 emissions per person and trip-day, with global average values",
                          style: TextStylesCustom.textStyles_14.apply(
                              fontWeightDelta: 2,
                              color: ColorStyle.greyColor_606060),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 300,
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.6,
                                      dashLength: 10.0,
                                      dashColor: ColorStyle.greyColor_0E6E6E6,
                                      // dashGradient: [Colors.red, Colors.blue],
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      // dashGapColor: Colors.transparent,
                                      // dashGapGradient: [Colors.red, Colors.blue],
                                      dashGapRadius: 10.0,
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.6,
                                      dashLength: 10.0,
                                      dashColor: ColorStyle.greyColor_0E6E6E6,
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapRadius: 10.0,
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: SfCartesianChart(
                                      // margin: EdgeInsets.all(0),
                                      primaryXAxis:
                                          CategoryAxis(isVisible: false),
                                      primaryYAxis: NumericAxis(
                                          minimum: 0,
                                          maximum: 100,
                                          interval: 100),
                                      tooltipBehavior: _tooltip,
                                      // legend: Legend(
                                      //   isVisible: true,
                                      //   alignment: ChartAlignment.center,
                                      //   position: LegendPosition.top,
                                      //   padding: 0,
                                      //   iconWidth: 0,
                                      //   itemPadding: 0,
                                      //   width: '40',
                                      //   height: '40',
                                      // ),
                                      // palette: [
                                      //   Colors.red,
                                      //   Colors.yellow,
                                      // ],
                                      series: <ChartSeries<ChartData, String>>[
                                        ColumnSeries<ChartData, String>(
                                          dataSource:
                                              controller.arrCodeIntensity,
                                          pointColorMapper:
                                              (ChartData data, _) => data.color,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          name: 'Gold',
                                          // width: 100,
                                          // isTrackVisible: true,
                                          // xAxisName: 'asdf',
                                          // yAxisName: 'ferfr',
                                          // trackBorderColor: Colors.red,
                                          // trackColor: Colors.red,
                                          spacing: 2,
                                          // isVisible: false,
                                          isVisibleInLegend: false,
                                          // width: 0.2,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                          // color: Color.fromRGBO(8, 142, 255, 1)
                                        ),
                                      ]),
                                ),
                                bottom: 0,
                                left: 0,
                                right: 0,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: ColorStyle.redColor_0F15222,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 10,
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Text(
                                  "My C02 emissions (kg/p-day)",
                                  style: TextStylesCustom.textStyles_12.apply(
                                      fontWeightDelta: 2,
                                      color: ColorStyle.greyColor_606060),
                                ))
                              ],
                            )),
                            const SizedBox(
                              width: 18,
                            ),
                            Expanded(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: ColorStyle.blueSkyColor_61AFF6,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 10,
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Text(
                                  "Average Values (kg/p-day)",
                                  style: TextStylesCustom.textStyles_12.apply(
                                      fontWeightDelta: 2,
                                      color: ColorStyle.greyColor_606060),
                                ))
                              ],
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButtonCustom(
                              keyCustom: Key('Back to calculations'),
                              text: 'Back to calculations',
                              // width: MediaQuery.of(context).size.width / 2,
                              height: 60,
                              colorBG: ColorStyle.yellowColor_0FDC530,
                              style: TextStylesCustom.textStyles_16.apply(
                                  color: Colors.black, fontWeightDelta: 3),
                              // isLoading: false,
                              onTap: () {
                                Navigator.pop(context);
                                // navigateMultiBottom(context, DonationInfo());
                              },
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: ElevatedButtonCustom(
                              keyCustom: Key('Save and Offset'),
                              text: 'Save and Offset',
                              // width: MediaQuery.of(context).size.width / 2,
                              height: 60,
                              colorBG: ColorStyle.greenColor_52BC7F,
                              style: TextStylesCustom.textStyles_16.apply(
                                  color: Colors.white, fontWeightDelta: 3),
                              // isLoading: false,
                              onTap: () {
                                navigateMultiBottom(
                                    context, DonationProjectListingScreen(isFromSupportedProjectsScreen: false,));
                              },
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: ElevatedButtonCustom(
                              keyCustom: Key('Save and Exit'),
                              text: 'Save and Exit',
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              colorBG: ColorStyle.greenColor_52BC7F,
                              style: TextStylesCustom.textStyles_16.apply(
                                  color: Colors.white, fontWeightDelta: 3),
                              // isLoading: false,
                              onTap: () {
                                NotificationCenter().notify('reloadAppBar');
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// 1. First Value Selected in all drop down menu
// 2. No and Yes option showing in round trip instead of 1 and 2
// 3. Google Address API should be integrated to all address fields
// 4. Top Green button would be redirected to the calculation page
// 5. Need to show 6 icons in a single row
// 6. Dynamic Form Validation Message
