import 'dart:developer';

import 'package:flutter_html/flutter_html.dart';
import 'package:tuco2/Controllers/StaticPageController.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;
import '../Controllers/FrequentlyAskedQuestionsController.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  FrequentlyAskedQuestions({
    super.key,
  });

  final controller = Get.put(FrequentlyAskedQuestionController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FrequentlyAskedQuestionController(),
        initState: (_) {
          controller.initFunction();
        },
        builder: (controller) {
          return Obx(() => Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                      width: Get.size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child:
                          // controller.pageDetails.isNotEmpty
                          //     ?
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [

                              Image.asset(
                                ImageStyle.faqs,
                                color:  ColorStyle.primaryColor_52BC7F,
                                height: 24,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'FAQs',
                                style: TextStylesCustom.textStylesBold_24.apply(
                                    fontWeightDelta: 1,
                                    color: ColorStyle.greyColor_606060),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (controller.faqs.isNotEmpty)
                            ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: Get.size.width,
                                    // height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorStyle.greyColor_0E6E6E6,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (controller.selected.value ==
                                                index + 1) {
                                              controller.selected.value = 0;
                                              controller.update();
                                            } else {
                                              controller.selected.value =
                                                  index + 1;
                                              controller.update();
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 18,
                                                bottom:
                                                    controller.selected.value ==
                                                            index + 1
                                                        ? 0
                                                        : 18),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  controller.faqs[index]
                                                      ['name'],
                                                  style: TextStylesCustom
                                                      .textStylesBold_16
                                                      .apply(
                                                    color: ColorStyle
                                                        .greyColor_606060,
                                                  ),
                                                )),
                                                Icon(
                                                    controller.selected.value ==
                                                            index + 1
                                                        ? Icons.expand_more
                                                        : Icons.navigate_next)
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (controller.selected.value ==
                                            index + 1)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (controller.selected.value ==
                                            index + 1)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7),
                                            child: Html(
                                                data:
                                                    """${controller.faqs[index]['content']}""",
                                                style: {
                                                  'p': Style(
                                                    fontFamily: kFontFamily,
                                                    fontSize: FontSize(10),
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorStyle
                                                        .greyColor_606060,
                                                  )
                                                },
                                                onLinkTap: (String? url,
                                                    RenderContext context,
                                                    Map<String, String>
                                                        attributes,
                                                    dom.Element?
                                                        element) async {
                                                  await launchUrl(
                                                      Uri.parse(url!));
                                                }),
                                          ),
                                        // Text('tuC02 provides an easy to use yet sophisticated and scientifically proven tool, that helps to calculate and offset your travel carbon footprint, achieving Net Zero travel! tuC02 calculator can be used for flights, trains, cruises, hotels and more. Furthermore, on our website you can find tips on how to reduce the carbon emissions produced by your trip, and suggestions for low or net zero carbon hotels, transportation, and other activities.', style: TextStylesCustom.textStyles_14.apply(color: ColorStyle.greyColor_606060, overflow: TextOverflow.visible),)
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 16,
                                  );
                                },
                                itemCount: controller.faqs.length),
                          SizedBox(
                            height: 32,
                          ),
                        ],
                      )
                      //     : SizedBox(
                      //   height: 0,
                      // ),
                      ),
                ),
              ));
        });
  }
}
