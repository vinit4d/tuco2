import 'package:notification_center/notification_center.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:tuco2/Views/CarbonFootprint.dart';

import '../Controllers/AddTransportationController.dart';

class AddTransportation extends StatefulWidget {
  const AddTransportation({Key? key, required this.tripID}) : super(key: key);

  final String tripID;

  @override
  State<AddTransportation> createState() => _AddTransportationState();
}

class _AddTransportationState extends State<AddTransportation> {
  final controller = Get.put(AddTransportationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 900), () {
      NotificationCenter().notify('reloadAppBar', data: true);

      NotificationCenter().subscribe('transportList', transportList);

      NotificationCenter().subscribe('total_co2', total_co2);
    });
  }

  transportList() {
    controller.transportList();
  }

  total_co2(String total_co2Value) {
    controller.total_co2.value = total_co2Value;
  }

  @override
  Widget build(BuildContext context) {
    NotificationCenter().subscribe('navigateToCarbonFootPrint', () {
      navigateMultiBottom(context, CarbonFootprint());
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: AddTransportationController(),
        initState: (_) {
          Future.delayed(const Duration(milliseconds: 900), () {
            controller.tripID = widget.tripID;
            controller.initCustom();
          });
        },
        builder: (_) {
          return Obx(() => Column(
                children: [
                  // Text(controller.addTransport.value),
                  Expanded(
                      child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 30,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            left: 16,
                            right: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                  ),
                                  child: Text(
                                      'Add details for the transport modes used for each leg of your journey, and the accommodation for all the stops.',
                                      style:
                                          TextStylesCustom.textStyles_16.apply(
                                        color: ColorStyle.greyColor_606060,
                                        fontWeightDelta: 3,
                                      )),
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorStyle.primaryColor_52BC7F,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    '${controller.total_co2.value} KG',
                                    style: TextStylesCustom.textStyles_16.apply(
                                        fontWeightDelta: 4,
                                        color: Colors.white),
                                  ),
                                ),
                                onTap: () {
                                  navigateMultiBottom(
                                    context, CarbonFootprint());
                              //  fsdhfh   NotificationCenter()
                              //         .notify('navigateToCarbonFootPrint');
                                },
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 96,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            itemCount: controller.arrTransports.length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 20,
                              );
                            },
                            itemBuilder: (context, index) {
                              final imageTrying =
                                  controller.arrTransports[index]['image'];
                              return InkWell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      imageTrying,
                                      height: 30.0,
                                      width: 30.0,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                        controller.arrTransports[index]['name'],
                                        style: TextStylesCustom.textStyles_14
                                            .apply(
                                                color: (controller
                                                        .arrSelected[index]
                                                    ? Colors.black
                                                    : ColorStyle
                                                        .greyColor_0A09F99),
                                                fontWeightDelta: 2)),
                                    Container(
                                      height: 3,
                                      width: controller.arrSelected[index]
                                          ? (index == 0)
                                              ? 60
                                              : 40
                                          : 0,
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: controller.arrSelected[index]
                                              ? ColorStyle.hex('#2C2C2E')
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  controller.selectTransportation(index);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          itemCount: controller.arrTransportsList.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (context, index) {
                            return controller.arrTransportsList.length > 0
                                ? Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                color: ColorStyle.greyColor_0A09F99
                                    .withOpacity(0.05),
                                border: Border.all(
                                    color: ColorStyle.greyColor_0E6E6E6,
                                    width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    controller.selectedTransportImage,
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            controller.labelFrom(controller
                                                    .arrTransportsList[index]
                                                ['user_data']),
                                            // 'Departure from',
                                            style: TextStylesCustom
                                                .textStyles_14
                                                .apply(
                                                    color: ColorStyle
                                                        .greyColor_606060,
                                                    fontWeightDelta: 2)),
                                        Text(
                                          controller.valueFrom(controller
                                                  .arrTransportsList[index]
                                              ['user_data']),
                                          style: TextStylesCustom.textStyles_16
                                              .apply(
                                            color: ColorStyle.greyColor_606060,
                                            fontWeightDelta: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  // line_Dotted started
                                  Container(
                                    padding: const EdgeInsets.only(
                                      // left: 10,
                                      right: 10,
                                    ),
                                    child: Image.asset(
                                      ImageStyle.line_Dotted,
                                      height: 54,
                                    ),
                                  ),
                                  // line_Dotted started

                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          controller.labelTo(controller
                                                  .arrTransportsList[index]
                                              ['user_data']),
                                          style: TextStylesCustom.textStyles_14
                                              .apply(
                                                  color: ColorStyle
                                                      .greyColor_606060,
                                                  fontWeightDelta: 2)),
                                      Text(
                                        controller.valueTo(
                                            controller.arrTransportsList[index]
                                                ['user_data']),
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        child: Image.asset(
                                          ImageStyle.edit,
                                          width: 20,
                                        ),
                                        onTap: () {
                                          final user_data = controller
                                                  .arrTransportsList[index]
                                              ['user_data'];

                                          final dictUserData =
                                              json.decode(user_data);
                                          // final dictUserData2 =
                                          //     json.decode(dictUserData);
                                          final arrUserData =
                                              List<Map<String, dynamic>>.from(
                                                  dictUserData);

                                          controller.updateNewFlight(index,
                                              arrTransformData: arrUserData);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          ImageStyle.delete,
                                          width: 20,
                                        ),
                                        onTap: () {
                                          controller.deleteTransportDialog(
                                              context, index);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                                  )
                                : Container();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: InkWell(
                            child: Column(
                              children: [
                                Image.asset(
                                  ImageStyle.addIcon,
                                  fit: BoxFit.fill,
                                  height: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Add new ${controller.selectedTransportName.toLowerCase()}',
                                  // 'Next',
                                  style: TextStylesCustom.textStyles_16.apply(
                                    color: ColorStyle.greyColor_606060,
                                    fontWeightDelta: 2,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              controller.addNewFlight();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )),
                  Row(
                    children: [
                      Expanded(
                          child: Image.asset(
                        ImageStyle.cartoon_toucan_bird,
                        fit: BoxFit.fill,
                        height: 160,
                      )),
                      // const SizedBox(
                      //   width: 16,
                      // ),
                      Expanded(
                          child: Image.asset(
                        ImageStyle.discount,
                        fit: BoxFit.fill,
                        height: 160,
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  )
                ],
              ));
        },
      ),
    );
  }
}
