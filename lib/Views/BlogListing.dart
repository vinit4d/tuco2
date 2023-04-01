import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

import '../Controllers/BlogListingController.dart';
import 'BlogDetails.dart';

class BlogListing extends StatelessWidget {
  BlogListing({super.key});

  final controller = Get.put(BlogListingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BlogListingController(),
        initState: (_) {
          controller.getTipsSuggestionData();
        },
        builder: (controller) {
          return Obx(() => Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    width: Get.size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: controller.tipsSuggestionsData.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 31,
                              ),
                              Text(
                                'Tips & suggestions',
                                style: TextStylesCustom.textStylesBold_24.apply(
                                    fontWeightDelta: 1,
                                    color: ColorStyle.greyColor_606060),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
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
                                      controller.tipsSuggestionsData[0]
                                          ['banner'],
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
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
                                      controller.tipsSuggestionsData[0]
                                          ['category_name'],
                                      style: TextStylesCustom.textStyles_10
                                          .apply(
                                              color:
                                                  ColorStyle.greyColor_606060),
                                    ),
                                  ),
                                  Text(
                                    'Jan 1, 2023 · 3344 Views',
                                    style: TextStylesCustom.textStyles_10.apply(
                                        color: ColorStyle.greyColor_606060),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                controller.tipsSuggestionsData[0]['name'],
                                style: TextStylesCustom.textStylesBold_16
                                    .apply(color: ColorStyle.greyColor_606060),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: Get.size.width,
                                child: Text(
                                  controller.tipsSuggestionsData[0]['intro'],
                                  style: TextStylesCustom.textStyles_14.apply(
                                      color: ColorStyle.greyColor_606060,
                                      overflow: TextOverflow.visible,
                                      heightFactor: 2),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Divider(
                                thickness: 2,
                                color: ColorStyle.greyColor_0E6E6E6,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Container(
                                width: Get.size.width,
                                child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return Container(
                                        width: Get.size.width,
                                        child: InkWell(
                                          onTap: () {
                                            navigateMultiBottom(
                                                context,
                                                BlogDetails(
                                                  blogId: controller
                                                          .tipsSuggestionsData[
                                                      index]['id'],
                                                ));
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 88,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Image.network(
                                                  controller
                                                          .tipsSuggestionsData[
                                                      index]['banner'],
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    minHeight: 80),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.size.width *
                                                            0.64,
                                                        child: Text(
                                                          controller
                                                                  .tipsSuggestionsData[
                                                              index]['name'],
                                                          style: TextStylesCustom
                                                              .textStylesBold_16
                                                              .apply(
                                                                  color: ColorStyle
                                                                      .greyColor_606060,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .visible),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      SizedBox(
                                                        width: Get.size.width *
                                                            0.64,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                              child: Text(
                                                                controller.tipsSuggestionsData[
                                                                        index][
                                                                    'category_name'],
                                                                style: TextStylesCustom
                                                                    .textStyles_10
                                                                    .apply(
                                                                        color: ColorStyle
                                                                            .greyColor_606060),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Jan 1, 2023 · 3344 Views',
                                                              style: TextStylesCustom
                                                                  .textStyles_10
                                                                  .apply(
                                                                      color: ColorStyle
                                                                          .greyColor_606060),
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
                                      );
                                    }),
                                    separatorBuilder: ((context, index) =>
                                        SizedBox(
                                          height: 31,
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
