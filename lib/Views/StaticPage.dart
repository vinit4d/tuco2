import 'package:flutter_html/flutter_html.dart';
import 'package:tuco2/Controllers/StaticPageController.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class StaticPage extends StatelessWidget {
  StaticPage({super.key, required this.pageName});

  final pageName;

  final controller = Get.put(StaticPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        initState: (_) {
          // controller.reset();
          controller.initFunction(pageName);
        },
        builder: (controller) {
          return Obx(() => Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    width: Get.size.width,
                    child: controller.pageDetails.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text(
                                  controller.pageDetails['name'],
                                  style: TextStylesCustom.textStylesBold_24
                                      .apply(
                                          fontWeightDelta: 1,
                                          color: ColorStyle.greyColor_606060),
                                ),
                              ),
                              controller.media.value.isNotEmpty ||
                                      controller.pageDetails['image'] != null
                                  ? SizedBox(
                                      height: 15,
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              controller.media.value.isNotEmpty
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      // width: Get.size.width,
                                      height: 250,
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              // height: Get.size.height,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: Get.size.width,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      // border: Border.all(width: 1, color: Colors.black),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // Image border
                                                      child: Image.network(
                                                          controller.media[0],
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    // width: 200,
                                                    child: FittedBox(
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // Image border
                                                            child: Image.network(
                                                                controller
                                                                    .media[1],
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // Image border
                                                            child: Image.network(
                                                                controller
                                                                    .media[2],
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8), // Image border
                                                child: Image.network(
                                                    controller.media[3],
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : controller.pageDetails['image'] != null
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          width: Get.size.width,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            // border: Border.all(width: 1, color: Colors.black),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                8), // Image border
                                            child: Image.network(
                                                controller.pageDetails['image'],
                                                fit: BoxFit.cover),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                              // SizedBox(
                              //   height: 14,
                              // ),
                              controller.pageDetails['content'] != null
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      width: Get.size.width,
                                      child: Html(


                                        data:
                                            """${controller.pageDetails['content']}""",
                                        onLinkTap: (String? url,
                                            RenderContext context,
                                            Map<String, String> attributes,
                                            dom.Element? element) async {
                                          await launchUrl(Uri.parse(url!));
                                        },
                                        style: {
                                          'p': Style(
                                            fontFamily: kFontFamily,
                                            fontSize: FontSize(10),
                                            fontWeight: FontWeight.w600,
                                            color: ColorStyle.greyColor_606060,
                                          )
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      height: 5,
                                    ),
                              SizedBox(
                                height: 32,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 0,
                          ),
                  ),
                ),
              ));
        });
  }
}
