import 'package:flutter_html/flutter_html.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/dom.dart' as dom;
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controllers/BlogListingController.dart';

class BlogDetails extends StatelessWidget {
  BlogDetails({super.key, required this.blogId});
  final blogId;
  final controller = Get.put(BlogListingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BlogListingController(),
        initState: (_) {
          controller.getBlogDetails(blogId);
        },
        builder: (controller) {
          return Obx(() => Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    width: Get.size.width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: controller.blogDetails.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  controller.blogDetails['name'],
                                  style: TextStylesCustom.textStyles_22.apply(
                                      fontWeightDelta: 2,
                                      color: ColorStyle.greyColor_606060),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: ColorStyle.greyColor_606060
                                            .withOpacity(.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        controller.blogDetails['category_name'],
                                        style: TextStylesCustom.textStyles_10
                                            .apply(
                                                color: ColorStyle
                                                    .greyColor_606060),
                                      ),
                                    ),
                                    Text(
                                      'Jan 1, 2023 · 3344 Views',
                                      style: TextStylesCustom.textStyles_10
                                          .apply(
                                              color:
                                                  ColorStyle.greyColor_606060),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: Get.size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  // border: Border.all(width: 1, color: Colors.black),
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(8), // Image border
                                  child: Image.network(
                                      controller.blogDetails['banner'],
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  controller.blogDetails['intro'],
                                  style: TextStylesCustom.textStyles_14.apply(
                                      color: ColorStyle.greyColor_606060,
                                      overflow: TextOverflow.visible,
                                      fontWeightDelta: 2,
                                      heightFactor: 2),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: Get.size.width,
                                child: Html(
                                  data:
                                      """${controller.blogDetails['content']}""",
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
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      'View more',
                                      style: TextStylesCustom.textStyles_16
                                          .apply(
                                              color:
                                                  ColorStyle.greyColor_606060,
                                              fontWeightDelta: 3),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: ColorStyle.greyColor_0E6E6E6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: Get.size.width,
                                child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return controller.tipsSuggestionsData[
                                                  index]['id'] !=
                                          controller.idx.value
                                          ? Container(
                                              width: Get.size.width,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.getBlogDetails(
                                                      controller
                                                              .tipsSuggestionsData[
                                                          index]['id']);
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 88,
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Image.network(
                                                        controller
                                                                .tipsSuggestionsData[
                                                            index]['banner'],
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                              minHeight: 80),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: Get.size
                                                                      .width *
                                                                  0.64,
                                                              child: Text(
                                                                controller.tipsSuggestionsData[
                                                                        index]
                                                                    ['name'],
                                                                style: TextStylesCustom
                                                                    .textStylesBold_16
                                                                    .apply(
                                                                        color: ColorStyle
                                                                            .greyColor_606060,
                                                                        overflow:
                                                                            TextOverflow.visible),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            SizedBox(
                                                              width: Get.size
                                                                      .width *
                                                                  0.64,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            6,
                                                                        vertical:
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorStyle
                                                                          .greyColor_606060
                                                                          .withOpacity(
                                                                              .1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                    ),
                                                                    child: Text(
                                                                      controller
                                                                              .tipsSuggestionsData[index]
                                                                          [
                                                                          'category_name'],
                                                                      style: TextStylesCustom
                                                                          .textStyles_10
                                                                          .apply(
                                                                              color: ColorStyle.greyColor_606060),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Jan 1, 2023 · 3344 Views ${blogId}',
                                                                    style: TextStylesCustom
                                                                        .textStyles_10
                                                                        .apply(
                                                                            color:
                                                                                ColorStyle.greyColor_606060),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 0,
                                            );
                                    }),
                                    separatorBuilder: ((context, index) =>
                                        controller.tipsSuggestionsData[index]
                                                    ['id'] !=
                                                blogId
                                            ? SizedBox(
                                                height: 31,
                                              )
                                            : SizedBox(
                                                height: 0,
                                              )),
                                    itemCount:
                                        controller.tipsSuggestionsData.length),
                              )
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
