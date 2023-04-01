import 'package:tuco2/Controllers/DonationProjectListingController.dart';

import '../../ExportFiles/ExportFilesMust.dart';
import '../../Views/Donation/DonationInfo.dart';
import '../../Views/Donation/DonationProceed.dart';
import '../MyCalculationHistory.dart';

class DonationProjectListingScreen extends StatefulWidget {
  DonationProjectListingScreen(
      {Key? key, required this.isFromSupportedProjectsScreen})
      : super(key: key);

  bool isFromSupportedProjectsScreen = false;

  @override
  State<DonationProjectListingScreen> createState() =>
      _DonationProjectListingScreenState();
}

class _DonationProjectListingScreenState
    extends State<DonationProjectListingScreen> {
  final controller = Get.put(DonationProjectListingController());

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
          init: DonationProjectListingController(),
          initState: (_) {
            Future.delayed(const Duration(milliseconds: 500), () {
              controller.initCustom();
            });
          },
          builder: (_) {
            return Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose a project to offset your C02 emissions",
                      style: TextStylesCustom.textStyles_24.apply(
                          fontWeightDelta: 3,
                          color: ColorStyle.greyColor_606060),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Carbon footprint data tracks human greenhouse gas emissions to reduce and mitigate climate change.",
                      style: TextStylesCustom.textStyles_14.apply(
                          fontWeightDelta: 2,
                          color: ColorStyle.greyColor_606060),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListView.separated(
                      padding: const EdgeInsets.only(
                          // left: 16,
                          // right : 16,
                          ),
                      itemCount: controller.arrProjects.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 30,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 12,
                            bottom: 12,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: ColorStyle.greyColor_0E6E6E6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      // spreadRadius: 5,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    controller.arrProjects[index]['banner']
                                        .toString(),
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit.cover,
                                  ),

                                  // CachedNetworkImage(
                                  //   // height: 110,
                                  //   // width: 110,
                                  //   fit: BoxFit.cover,
                                  //   imageUrl: controller.arrProjects[index]
                                  //           ['banner']
                                  //       .toString(),
                                  //   progressIndicatorBuilder:
                                  //       (context, url, downloadProgress) =>
                                  //           CircularProgressIndicator(
                                  //     value: downloadProgress.progress,
                                  //     color: ColorStyle.hex('#FF3984'),
                                  //   ),
                                  //   errorWidget: (context, url, error) =>
                                  //       Container(
                                  //     height: 140,
                                  //     // width: 136,
                                  //     margin: const EdgeInsets.all(10),
                                  //     child: Icon(
                                  //       Icons.co2,
                                  //       size: 140,
                                  //       color: ColorStyle.primaryColor_52BC7F
                                  //           .withOpacity(0.2),
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                  controller.arrProjects[index]['name']
                                      .toString(),
                                  style: TextStylesCustom.textStyles_16.apply(
                                      color: ColorStyle.greyColor_606060,
                                      fontWeightDelta: 3)),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                  '${controller.arrProjects[index]['sale_price'] != null ?
                                  controller.arrProjects[index]['sale_price'].toString() :
                                  controller.arrProjects[index]['price'].toString()}€ per ton',
                                  style: TextStylesCustom.textStyles_24.apply(
                                      color: ColorStyle.greenColor_52BC7F,
                                      fontWeightDelta: 3)),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButtonCustom(
                                    keyCustom: Key('Information'),
                                    text: 'Information',
                                    // width: MediaQuery.of(context).size.width / 2,
                                    height: 40,
                                    colorBG: ColorStyle.yellowColor_0FDC530,
                                    style: TextStylesCustom.textStyles_16.apply(
                                        color: Colors.black,
                                        fontWeightDelta: 3),
                                    // isLoading: false,
                                    onTap: () {
                                   
                                      navigateMultiBottom(
                                          context,
                                          DonationInfo(
                                            projectID: controller
                                                .arrProjects[index]['id']
                                                .toString(),
                                          ));
                                    },
                                  )),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                      child: ElevatedButtonCustom(
                                    keyCustom: Key('Offset'),
                                    text: 'Offset',
                                    // width: MediaQuery.of(context).size.width / 2,
                                    height: 40,
                                    colorBG: ColorStyle.greenColor_52BC7F,
                                    style: TextStylesCustom.textStyles_16.apply(
                                        color: Colors.white,
                                        fontWeightDelta: 3),
                                    // isLoading: false,
                                    onTap: () {
                                      debugPrint(
                                          "isFromSupportedProjectsScreen.. ${widget.isFromSupportedProjectsScreen}");
                                      if (widget
                                          .isFromSupportedProjectsScreen) {
                                        navigateMultiBottom(context,
                                            MyCalculationHistoryScreen());
                                      } else
                                      navigateMultiBottom(
                                          context,
                                          DonationProceed(
                                            dictProjectsDetails:
                                                controller.arrProjects[index],
                                          ));
                                    },
                                  )),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}
