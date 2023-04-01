import 'package:dotted_line/dotted_line.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:tuco2/Views/TripScreen.dart';

import '../Components/Text.dart';
import '../Controllers/DashboardController.dart';
import '../Controllers/ProfileController.dart';
import '../Models/ChartData.dart';
import 'DrawerCustom.dart';
import 'MyCalculationHistory.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = Get.put(DashboardController());

  final profileController = Get.put(ProfileController());

  onPressedPhotoPicker() {
    // PickerCustom.imagePicker(
    //   (file) async {
    //     controller.image.value = file;
    //   },
    // );
  }

  // static GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(),
      initState: (_) {
        controller.initMethod();
      },
      builder: (controller) {
        return Scaffold(
          drawer: DrawerCustom(),
          body: Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          InkWell(
                            onTap: onPressedPhotoPicker,
                            child: Center(
                              child: Stack(children: [
                                // if (controller.image.value.path.isEmpty)
                                
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(136),
                                      // color: Colors.grey.withOpacity(0.5),
                                      border: Border.all(
                                        color: ColorStyle.primaryColor_52BC7F,
                                        width: 3,
                                      )),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(68),
                                    child: Image.network(avatar.value,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, url, error) =>
                                            Image.network(
                                              'https://media.glamourmagazine.co.uk/photos/62ea5ac396a3ad6877093558/1:1/w_1920,h_1920,c_limit/AMBER%20HEARD%20TIDE%20TURN%20030822%20default-sq-GettyImages-1154257098.jpg',
                                              height: 100,
                                              width: 100,
                                            )),

                                    /*
                                        CachedNetworkImage(
                                            height: 90,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                            controller.profilePicture.value,
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                  value:
                                                  downloadProgress.progress,
                                                  color:
                                                  ColorStyle.hex('#FF3984'),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                Image.network(
                                                  'https://media.glamourmagazine.co.uk/photos/62ea5ac396a3ad6877093558/1:1/w_1920,h_1920,c_limit/AMBER%20HEARD%20TIDE%20TURN%20030822%20default-sq-GettyImages-1154257098.jpg',
                                                  height: 90,
                                                  width: 90,
                                                )
                                          //         Container(
                                          //   height: 90,
                                          //   width: 90,
                                          //   margin: const EdgeInsets.all(10),
                                          //   child: Icon(
                                          //     Icons.person,
                                          //     size: 54,
                                          //     color: ColorStyle
                                          //         .primaryColor_52BC7F,
                                          //   ),
                                          // ),
                                        )
                  */
                                  ),
                                ),
                                // else
                                //   Container(
                                //     padding: const EdgeInsets.all(4),
                                //     decoration: BoxDecoration(
                                //         borderRadius:
                                //             BorderRadius.circular(136),
                                //         border: Border.all(
                                //           color: ColorStyle.primaryColor_52BC7F,
                                //           width: 3,
                                //         )),
                                //     child: CircleAvatar(
                                //       backgroundColor:
                                //           ColorStyle.primaryColor_52BC7F,
                                //       radius: 45,
                                //       child: ClipRRect(
                                //           borderRadius:
                                //               BorderRadius.circular(68),
                                //           child: Image.file(
                                //             File(controller.image.value.path),
                                //             fit: BoxFit.fill,
                                //             height: 90,
                                //             width: 90,
                                //           )),
                                //     ),
                                //   ),
                                Positioned(
                                    bottom: 0,
                                    right: -20,
                                    child: RawMaterialButton(
                                      onPressed: onPressedPhotoPicker,
                                      // controller.getImage(),
                                      elevation: 2,
                                      fillColor: Colors.white,
                                      padding: const EdgeInsets.all(8.0),
                                      shape: const CircleBorder(),
                                      child: Image.asset(
                                        ImageStyle.editProfile,
                                        width: 16,
                                      ),
                                    )),
                              ]),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                              child: headingGreenText('Welcome ' +
                                  profileController.firstName.text.toString())),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      BoldText('My travel carbon footprint dashboard',
                          ColorStyle.greyColor_606060),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.6,
                            height: MediaQuery.of(context).size.height / 2.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorStyle.greyColor_0E6E6E6,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Column(children: [
                                SizedBox(
                                  height: 12,
                                ),
                                BoldText('C02 emissions',
                                    ColorStyle.greyColor_606060),
                                SizedBox(
                                  height: 7,
                                ),
                                normalText(
                                    'The total C02 emissions produced from my trips until now is:'),
                                SizedBox(
                                  height: 14,
                                ),
                                BoldText(
                                    controller.totalEmissions.string + ' kg',
                                    ColorStyle.redColor_0F15222),
                                SizedBox(
                                  height: 7,
                                ),
                                normalText('The total person-tripdays is:'),
                                SizedBox(
                                  height: 7,
                                ),
                                BoldText(controller.totalPersons.string,
                                    ColorStyle.greenColor_52BC7F),
                                SizedBox(
                                  height: 7,
                                ),
                                normalText(
                                    'The C02 emissions per person and trip-day is:'),
                                SizedBox(
                                  height: 7,
                                ),
                                BoldText(
                                    controller.totalEmissionsPerPerson.string +
                                        ' kg / p-day',
                                    ColorStyle.redColor_0F15222),
                                SizedBox(
                                  height: 7,
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                                width: MediaQuery.of(context).size.width / 2.6,
                            height: MediaQuery.of(context).size.height / 2.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorStyle.greyColor_0E6E6E6,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  BoldText('Carbon Offsets',
                                      ColorStyle.greyColor_606060),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  normalText('Until today, I have offset:'),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  BoldText(
                                      controller.carbonOffset.string + ' kg',
                                      ColorStyle.greenColor_52BC7F),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  normalText('Total C02 emissions:'),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    height: 120,
                                    child: Stack(
                                      children: [
                                        if (controller.carbonOffset == 0 &&
                                            controller.carbonOffsetPercent == 0)
                                          Container()
                                        else
                                          Positioned(
                                              top: 45,
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child: boldText12(controller
                                                      .carbonOffsetPercent
                                                      .string +
                                                  ' %')),
                                        if (controller.carbonOffset == 0 &&
                                            controller.carbonOffsetPercent == 0)
                                          Center(
                                            child: Text(
                                              'No Data Found',
                                              textAlign: TextAlign.center,
                                              style: TextStylesCustom
                                                  .textStylesBold_16
                                                  .apply(
                                                color:
                                                    ColorStyle.greyColor_606060,
                                                fontWeightDelta: 3,
                                              ),
                                            ),
                                          )
                                        else
                                          SfCircularChart(palette: [
                                            ColorStyle.greenColor_52BC7F,
                                            ColorStyle.redColor_0F15222,
                                 
                                          ], series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                              pointColorMapper:
                                                  (ChartData data, _) =>
                                                      data.color,
                                                dataSource: controller
                                                    .chartDataCarbonOffset,
                                                xValueMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, _) =>
                                                        data.y,
                                                         cornerStyle: CornerStyle.bothCurve,
                                                // Radius of doughnut
                                                radius: '90%',
                                                innerRadius: ' 80%',
                                                explode: true,
                                              explodeIndex: 1,
                                            )
                                          ])
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                            color: ColorStyle.greenColor_52BC7F,
                                            borderRadius:
                                                BorderRadius.circular(100)
                                            //more than 50% of width makes circle
                                            ),
                                      ),
                                      SizedBox(
                                         width: 5,
                                      ),
                                      normalTextFontsize10("Offset percentage")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                             width: MediaQuery.of(context).size.width / 2.4,
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorStyle.greyColor_0E6E6E6,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  BoldText('C02 emissions breakdown',
                                      ColorStyle.greyColor_606060),
                                  Container(
                                    height: 190,
                                    child: SfCircularChart(
                                      palette: [
                                        ColorStyle.blueSkyColor_61AFF6,
                                        ColorStyle.yellowColor_0FDC530,
                                        ColorStyle.redColor_0F15222,
                                        ColorStyle.greyColor_0A09F99,
                                        ColorStyle.blueColor_514899,
                                        ColorStyle.primaryColor_52BC7F,
                                      ],
                                      series: <CircularSeries>[
                                        DoughnutSeries<ChartData, String>(
                                          radius: '95%',
                                          dataSource:
                                              controller.arrCO2Emissions,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,

                                          explode: true,
                                          // explodeIndex: 1
                                          dataLabelSettings: DataLabelSettings(
                                              labelIntersectAction:
                                                  LabelIntersectAction.none,
                                              // labelPosition: ChartDataLabelPosition.outside,
                                              isVisible: true,
                                              connectorLineSettings:
                                                  ConnectorLineSettings(
                                                      type: ConnectorType.curve,
                                                      length: '5%')),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    
                                    children: [
                                      legends(
                                          'Airplane',
                                          'Boat',
                                          ColorStyle.blueSkyColor_61AFF6,
                                          ColorStyle.greyColor_0A09F99),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      legends(
                                          'Train',
                                          'Car',
                                          ColorStyle.yellowColor_0FDC530,
                                          ColorStyle.greenColor_52BC7F),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      legends(
                                          'Coach',
                                          'Accommodation',
                                          ColorStyle.pinkColor_F15222,
                                          ColorStyle.blueColor_514899)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                               width: MediaQuery.of(context).size.width / 2.4,
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorStyle.greyColor_0E6E6E6,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                    BoldText('C02 emission intensity',
                                        ColorStyle.greyColor_606060),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    normalText(
                                        'Comparison of C02 emissions per person and trip-day, with global average values'),
                                    Container(
                                      height: 160,
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                DottedLine(
                                                  direction: Axis.horizontal,
                                                  lineLength: double.infinity,
                                                  lineThickness: 1.6,
                                                  dashLength: 10.0,
                                                  dashColor: ColorStyle
                                                      .greyColor_0E6E6E6,
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
                                                  dashColor: ColorStyle
                                                      .greyColor_0E6E6E6,
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
                                          SfCartesianChart(
                                              plotAreaBorderWidth: 0,
                                              // margin: EdgeInsets.all(0),
                                              primaryXAxis: CategoryAxis(
                                                  isVisible: false),
                                              primaryYAxis: NumericAxis(
                                                isVisible: false,
                                                  minimum: 0,
                                                  maximum: 1000,
                                                interval: 100,
                                              ),
                                              series: <
                                                  ChartSeries<ChartData,
                                                      String>>[
                                                ColumnSeries<ChartData, String>(
                                                  dataSource: controller
                                                      .arrCO2EmissionIntensity,
                                                  pointColorMapper:
                                                      (ChartData data, _) =>
                                                          data.color,
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                  ),
                                                  // color: Color.fromRGBO(8, 142, 255, 1)
                                                ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: ColorStyle
                                                      .greenColor_52BC7F,
                                                  borderRadius:
                                                      BorderRadius.circular(100)
                                                  //more than 50% of width makes circle
                                                  ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            normalTextFontsize10(
                                                "My C02 emissions (kg/p-day)")
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: ColorStyle
                                                      .yellowColor_0FDC530,
                                                  borderRadius:
                                                      BorderRadius.circular(100)
                                                  //more than 50% of width makes circle
                                                  ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            normalTextFontsize10(
                                                "Average Values (kg/pday)")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButtonLoadingCustom(
                            keyCustom: 'Calculator',
                            text: 'Calculator',
                            width: MediaQuery.of(context).size.width / 2.5,
                            colorBG: ColorStyle.primaryColor_52BC7F,
                            style: TextStylesCustom.textStyles_16
                                .apply(color: Colors.white, fontWeightDelta: 3),
                            // isLoading: false,
                            // isLoading: controller.isLoading.value,
                            onTap: () {
                              navigateMultiBottom(context, TripScreen());
                            },
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          ElevatedButtonLoadingCustom(
                            keyCustom: 'History',
                            text: 'History',
                            width: MediaQuery.of(context).size.width / 2.5,
                            colorBG: ColorStyle.yellowColor_0FDC530,
                            style: TextStylesCustom.textStyles_16
                                .apply(color: ColorStyle.greyColor_082623, fontWeightDelta: 3),
                            // isLoading: false,
                            // isLoading: controller.isLoading.value,
                            onTap: () {
                              navigateMultiBottom(
                                  context, MyCalculationHistoryScreen());
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget legends(String text1, String text2, Color color1, Color color2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          // width: 60,
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    color: color1, borderRadius: BorderRadius.circular(100)
                    //more than 50% of width makes circle
                    ),
              ),
              SizedBox(
                width: 5,
              ),
              normalTextFontsize10(text1),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
         
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    color: color2, borderRadius: BorderRadius.circular(100)
                    //more than 50% of width makes circle
                    ),
              ),
              SizedBox(
                width: 5,
              ),
              normalTextFontsize10(text2)
            ],
          ),
        ),
      ],
    );
  }
}
