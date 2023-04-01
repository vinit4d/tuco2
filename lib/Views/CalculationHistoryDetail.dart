import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:tuco2/Views/Donation/DonationInfo.dart';

import '../Components/Text.dart';
import '../Controllers/CalculationHisoryDetailController.dart';
import '../Models/ChartData.dart';
import 'Donation/DonationProjectListingScreen.dart';

class MyCalculationHistoryDetailScreen extends StatelessWidget {
  int historyId;
  MyCalculationHistoryDetailScreen(
    this.historyId, {
    super.key,
  });

  final controller = Get.put(CalculationHisoryDetailController());

  List<ChartData> arrCO2Emissions = [
    ChartData('CHN', 80, ColorStyle.redColor_0F15222),
    ChartData('GER', 60, ColorStyle.blueSkyColor_61AFF6),
  ];

  final arrTransportsList = [
    'Airplane',
    'train',
    'Coach',
    'Car',
    'Boat',
    'Hotel'
  ];

  graphDoughnut() {
    return SizedBox(
      height: 430,
      // color: Colors.yellow,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: SfCircularChart(

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
                    pointColorMapper: (ChartData data, _) => data.color,
                    startAngle: 270,
                    endAngle: 90,
                  )
                ]),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total CO2 footprint",
                  textAlign: TextAlign.center,
                  style: TextStylesCustomPoppins.textStyles_14.apply(
                      fontWeightDelta: 2, color: ColorStyle.greyColor_606060),
                ),
                Text(
                  controller.total_emission_per_person.string + " KG",
                  textAlign: TextAlign.center,
                  style: TextStylesCustomPoppins.textStyles_30.apply(
                      fontWeightDelta: 8, color: ColorStyle.greyColor_606060),
                ),
              ],
            ),
          ),
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            child: Column(
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
              ],
            ),
          ),
          Positioned(
            top: 310,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(10.0), //clipping the whole widget
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: ColorStyle.greyColor_0E6E6E6, width: 1)),
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
                            controller.arrTransports[index]['transport_type']
                                .toString(),
                            style: TextStylesCustom.textStyles_14
                                .apply(fontWeightDelta: 3, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              controller.arrTransports[index]['kgs'].toString(),
                              style: TextStylesCustom.textStyles_18.apply(
                                fontWeightDelta: 3,
                                color: ColorStyle.greyColor_606060,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "kg",
                              style: TextStylesCustom.textStyles_18.apply(
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CalculationHisoryDetailController(),
        initState: (_) {
          Future.delayed(const Duration(milliseconds: 200), () {
            controller.initMethod(historyId);
          });
        },
        builder: (controller) {
          return Scaffold(
            body: Obx(
              () => controller.isLoading.value
                  ? loader()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 2),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 18,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                HeadingText(controller.start_date.isEmpty ? chnageDateFormat(
                                    controller.start_date.toString()) : ""),
                                InkWell(
                                  onTap: () {
                                    controller.deleteOffsetDialog(
                                        context, historyId);
                                  },
                                  child: Image.asset(
                                    ImageStyle.delete,
                                    width: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    stepsDestination(ImageStyle.location,
                                        controller.from.string),
                                    controller.via_1.string.isEmpty
                                        ? Container()
                                        : dottedLine(),
                                    controller.via_1.string.isEmpty
                                        ? Container()
                                        :
                                    stepsDestination(
                                        ImageStyle.locationDestinationIcon,
                                        controller.via_1.string),
                                    controller.via_2.string.isEmpty
                                        ? Container()
                                        : dottedLine(),
                                    controller.via_2.string.isEmpty
                                        ? Container()
                                        : stepsDestination(
                                        ImageStyle.locationDestinationIcon,
                                            controller.via_3.string),
                                    controller.via_3.string.isEmpty
                                        ? Container()
                                        : dottedLine(),
                                    controller.via_3.string.isEmpty
                                        ? Container()
                                        : stepsDestination(
                                        ImageStyle.locationDestinationIcon,
                                        controller.via_3.string),
                                    dottedLine(),
                                    stepsDestination(ImageStyle.location,
                                        controller.to.string)
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      color: ColorStyle.lightGreenColor_52BC7F,
                                      border: Border.all(
                                        color:
                                            ColorStyle.lightGreenColor_52BC7F,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      userDetail(ImageStyle.roundTripIcon,
                                          'Round Trip'),
                                      userDetail(
                                          ImageStyle.calenderIcon,
                                          controller.trip_days.string +
                                              ' Days'),
                                      userDetail(
                                          ImageStyle.user,
                                          controller.peoples.string +
                                              ' Persons')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.total_emission_per_person != 0
                                    ? graphDoughnut()
                                    : Center(
                                        child: Text(
                                          'No Data Found',
                                          textAlign: TextAlign.center,
                                          style: TextStylesCustom
                                              .textStylesBold_16
                                              .apply(
                                            color: ColorStyle.greyColor_606060,
                                            fontWeightDelta: 3,
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: ColorStyle.pinkColor_F15222,
                                    border: Border.all(
                                      color: ColorStyle.pinkColor_F15222,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: normalText('C02 intencity = ' +
                                        controller
                                            .total_emission_per_person.string +
                                        ' kg / p-day'),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButtonLoadingCustom(
                                  keyCustom: 'Offset',
                                  text: 'Offset',
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  colorBG: ColorStyle.primaryColor_52BC7F,
                                  style: TextStylesCustom.textStyles_16.apply(
                                      color: Colors.white, fontWeightDelta: 3),
                                  // isLoading: false,
                                  // isLoading: controller.isLoading.value,
                                  onTap: () {

                                      navigateMultiBottom(
                                          context,
                                          DonationInfo(
                                            projectID: historyId.toString(),
                                          ));
                                    // navigateMultiBottom(context,
                                    //     DonationProjectListingScreen(isFromSupportedProjectsScreen: false,));
                                
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: BoldText('Offset history', ColorStyle.greyColor_606060)),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.grey.withOpacity(0.5),
                                        // border: Border.all(
                                        //   color: ColorStyle.primaryColor_52BC7F,
                                        //   width: 3,
                                        // ),
                                      ),
                                      child: Image.network(
                                          controller.image.value,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, url, error) =>
                                              Image.network(
                                                'https://media.glamourmagazine.co.uk/photos/62ea5ac396a3ad6877093558/1:1/w_1920,h_1920,c_limit/AMBER%20HEARD%20TIDE%20TURN%20030822%20default-sq-GettyImages-1154257098.jpg',
                                                height: 50,
                                                width: 50,
                                              )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    BoldText(
                                        'Reforestation of degraded land in India',
                                        ColorStyle.greyColor_606060)
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                richText12(
                                    'Offset amount: ',
                                    controller.amount.toString() + ' €',
                                    ColorStyle.greenColor_52BC7F),
                                SizedBox(
                                  height: 15,
                                ),
                                richText12(
                                    'C02 emission value: ',
                                    controller.total_emission.toString() +
                                        ' KG',
                                    ColorStyle.redColor_0F15222),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButtonLoadingCustom(
                                  keyCustom: 'Certification',
                                  text: 'Certification',
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  colorBG: ColorStyle.primaryColor_52BC7F,
                                  style: TextStylesCustom.textStyles_16.apply(
                                      color: Colors.white, fontWeightDelta: 3),
                                  // isLoading: false,
                                  // isLoading: controller.isLoading.value,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}

Widget dottedLine() {
  return Image.asset(
    ImageStyle.line_Dotted,
    height: 32,
    width: 24,
  );
}

Widget stepsDestination(
  String location,
  String destination,
) {
  return Row(
    children: [
      Image.asset(
        location,
        height: 24,
        width: 24,
      ),
      SizedBox(
        width: 10,
      ),
      normalText(destination),
    ],
  );
}

Widget userDetail(
  String imagePath,
  String text,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          imagePath,
          height: 24,
          width: 24,
        ),
        SizedBox(
          width: 10,
        ),
        boldText12(text),
      ],
    ),
  );
}
