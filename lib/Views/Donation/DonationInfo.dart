import 'dart:async';

import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_unescape/html_unescape.dart';
import 'package:tuco2/Controllers/DonationInfoController.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ExportFiles/ExportFilesMust.dart';
import '../../Views/Donation/DonationProceed.dart';

class DonationInfo extends StatefulWidget {
  const DonationInfo({Key? key, required this.projectID}) : super(key: key);

  final String projectID;
  @override
  State<DonationInfo> createState() => _DonationInfoState();
}

class _DonationInfoState extends State<DonationInfo> {
  final controller = Get.put(DonationInfoController());

  var unescape = HtmlUnescape();

  final paddingCommon = EdgeInsets.only(
    left: 16,
    right: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: DonationInfoController(),
        initState: (_) {
          controller.projectID = widget.projectID;
          Future.delayed(const Duration(milliseconds: 500), () {
            controller.initCustom();
          });
        },
        builder: (_) {
          return Obx(() => SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      margin: paddingCommon,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            // spreadRadius: 5,
                            blurRadius: 4,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            controller.dictProjects['banner'].toString(),
                            fit: BoxFit.cover,
                            height: 140,
                            errorBuilder: (context, url, error) => Container(
                              height: 140,
                              // width: 136,
                              margin: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.co2,
                                size: 140,
                                color: ColorStyle.primaryColor_52BC7F
                                    .withOpacity(0.2),
                              ),
                            ),
                          ),

                          // CachedNetworkImage(
                          //   fit: BoxFit.cover,
                          //   imageUrl:
                          //       controller.dictProjects['banner'].toString(),
                          //   progressIndicatorBuilder:
                          //       (context, url, downloadProgress) =>
                          //           CircularProgressIndicator(
                          //     value: downloadProgress.progress,
                          //     color: ColorStyle.hex('#FF3984'),
                          //   ),
                          //   errorWidget: (context, url, error) => Container(
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(controller.dictProjects['name'].toString(),
                          style: TextStylesCustom.textStyles_24.apply(
                              color: ColorStyle.greyColor_606060,
                              fontWeightDelta: 3)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 4,
                        right: 4,
                      ),
                      child: Html(
                          data: unescape.convert(controller
                              .dictProjects['description']
                              .toString()),
                          style: {
                            'p': Style(
                                fontFamily: kFontFamily,
                                fontSize: FontSize(14),
                                fontWeight: FontWeight.w600,
                                color: ColorStyle.greyColor_606060,
                                padding: const EdgeInsets.all(0),
                                margin:
                                    Margins(left: Margin(0), right: Margin(0)))
                          },
                          onLinkTap: (String? url,
                              RenderContext context,
                              Map<String, String> attributes,
                              dom.Element? element) async {
                            await launchUrl(Uri.parse(url!));
                          }),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: paddingCommon,
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButtonCustom(
                            keyCustom: Key('View Other Projects'),
                            text: 'View Other Projects',
                            // width: MediaQuery.of(context).size.width / 2,
                            height: 54,
                            colorBG: ColorStyle.yellowColor_0FDC530,
                            style: TextStylesCustom.textStyles_16
                                .apply(color: Colors.black, fontWeightDelta: 3),
                            // isLoading: false,
                            onTap: () {
                              Navigator.pop(context);
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
                            height: 54,
                            colorBG: ColorStyle.greenColor_52BC7F,
                            style: TextStylesCustom.textStyles_16
                                .apply(color: Colors.white, fontWeightDelta: 3),
                            // isLoading: false,
                            onTap: () {
                              navigateMultiBottom(
                                  context,
                                  DonationProceed(
                                    dictProjectsDetails:
                                        controller.dictProjects,
                                  ));
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
