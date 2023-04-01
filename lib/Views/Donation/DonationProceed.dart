import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_unescape/html_unescape.dart';
import 'package:tuco2/Controllers/DonationProceedController.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ExportFiles/ExportFilesMust.dart';
import 'DonationBilling.dart';

class DonationProceed extends StatefulWidget {
  const DonationProceed({Key? key, required this.dictProjectsDetails})
      : super(key: key);

  final Map<String, dynamic> dictProjectsDetails;

  @override
  State<DonationProceed> createState() => _DonationProceedState();
}

class _DonationProceedState extends State<DonationProceed> {
  var unescape = HtmlUnescape();

  final paddingCommon = EdgeInsets.only(
    left: 16,
    right: 16,
  );

  final controller = Get.put(DonationProceedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
          init: DonationProceedController(),
          initState: (_) {
            controller.price.value =   widget.dictProjectsDetails['price'];
            controller.newPrice.value = controller.price.value;
            controller.initCustom();
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
                        color: Colors.white,
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
                        child: Image.network(
                          widget.dictProjectsDetails['banner'].toString(),
                          fit: BoxFit.cover,
                          height: 140,
                        ),

                        // CachedNetworkImage(
                        //   fit: BoxFit.cover,
                        //   imageUrl: widget.dictProjectsDetails['banner']
                        //       .toString(),
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
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: paddingCommon,
                      child: Text(widget.dictProjectsDetails['name'].toString(),
                          style: TextStylesCustom.textStyles_24.apply(
                              color: ColorStyle.greyColor_606060,
                              fontWeightDelta: 3)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Html(
                          data: unescape.convert(widget
                              .dictProjectsDetails['description']
                              .toString()),
                          style: {
                            'p': Style(
                              fontFamily: kFontFamily,
                              fontSize: FontSize(14),
                              fontWeight: FontWeight.w600,
                              color: ColorStyle.greyColor_606060,
                            )
                          },
                          onLinkTap: (String? url,
                              RenderContext context,
                              Map<String, String> attributes,
                              dom.Element? element) async {
                            await launchUrl(Uri.parse(url!));
                          }),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: paddingCommon,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: ColorStyle.greyColor_0E6E6E6,
                                      width: 1)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: ColorStyle.greyColor_0A09F99,
                                        ),
                                        onPressed: () {
                                          controller.priceDecrease();
                                        },
                                      ),
                                      Expanded(
                                        //controller.price.toString() + '€'
                                        child: Text(
                                            controller.itemCount.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStylesCustom.textStyles_20
                                                .apply(
                                                    color:
                                                        ColorStyle.greyColor_606060,
                                                    fontWeightDelta: 3)),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          size: 20,
                                          color: ColorStyle.greyColor_0A09F99,
                                        ),
                                        onPressed: () {
                                          controller.priceIncrease();
                                        },
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
              Expanded(
                            child: Text(controller.newPrice.toString() + ' €' ,
                                textAlign: TextAlign.center,
                                style: TextStylesCustom.textStyles_20.apply(
                                    color: ColorStyle.greyColor_606060,
                                    fontWeightDelta: 3)),
                          ),

                       
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),
                    Center(
                      child: Container(
                        width: 200,
                        child: ElevatedButtonCustom(
                          keyCustom: Key('Proceed to Offset'),
                          text: 'Proceed to Offset',
                          // width: MediaQuery.of(context).size.width / 2,
                          height: 54,
                          colorBG: ColorStyle.greenColor_52BC7F,
                          style: TextStylesCustom.textStyles_16
                              .apply(color: Colors.white, fontWeightDelta: 2),
                          // isLoading: false,
                          onTap: () {
                            navigateMultiBottom(
                                context,
                                DonationBilling(
                                  projectID: widget.dictProjectsDetails['id']
                                      .toString(),
                                  price: controller.price.value.toString(),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],

                )));
          }),
    );
  }
}
