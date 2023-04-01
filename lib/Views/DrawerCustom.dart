import 'dart:ui' as ui;

import 'package:notification_center/notification_center.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

import '../Controllers/StaticPageController.dart';

List<bool> arrSelected = [];

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  final arrIcons = [
    ImageStyle.home,
    ImageStyle.info,
    ImageStyle.calculator,
    ImageStyle.docs,
    ImageStyle.tips,
    ImageStyle.contactUs,
    ImageStyle.faqs,
    ImageStyle.privacy,
    ImageStyle.terms,
  ];

  final arrTitles = [
    'Home',
    'About Us',
    'Calculator',
    'Supported Projects',
    'Tips & Suggestions',
    'Contact Us',
    'FAQs',
    'Privacy Policy',
    'Terms & Conditions',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < arrTitles.length; i++) {
      arrSelected.add((i == 0) ? false : false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: InkWell(
          child: Row(
            children: [
              SafeArea(
                top: false,
                bottom: false,
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Image.asset(
                            ImageStyle.logoWithNamePNG,
                            width: 90,
                            // height: 30,
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  ImageStyle.cancel,
                                  height: 16,
                                ),
                              ),
                              onPressed: () {
                                Scaffold.of(context).closeDrawer();
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: ListView.separated(
                        padding: const EdgeInsets.only(
                          top: 30,
                          bottom: 30,
                          left: 24,
                          right: 24,
                        ),
                        itemCount: arrTitles.length,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                                top: 12,
                                bottom: 12,
                              ),
                              decoration: arrSelected[index]
                                  ? BoxDecoration(
                                      color: ColorStyle.primaryColor_52BC7F,
                                      borderRadius: BorderRadius.circular(8))
                                  : const BoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    arrIcons[index],
                                    color: arrSelected[index]
                                        ? Colors.white
                                        : ColorStyle.primaryColor_52BC7F,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child: Text(arrTitles[index],
                                          style: TextStylesCustom.textStyles_17
                                              .apply(
                                                  color: arrSelected[index]
                                                      ? Colors.white
                                                      : ColorStyle
                                                          .greyColor_606060,
                                                  fontWeightDelta: 3))),
                                ],
                              ),
                            ),
                            onTap: () {
                              // Scaffold.of(context).closeDrawer();
                              // Scaffold.of(context).closeDrawer();
                              // debugPrint(index.toString());

                              // Scaffold.of(context).closeDrawer();

                              Navigator.pop(context);

                              // Get.back();

                              for (int i = 0; i < arrSelected.length; i++) {
                                if (index == i) {
                                  arrSelected[i] = true;
                                } else {
                                  arrSelected[i] = false;
                                }
                              }

                              // setState(() {});

                              if (arrTitles[index]
                                  .toLowerCase()
                                  .contains('home'.toLowerCase())) {
                                NotificationCenter()
                                    .notify('navigateFromDrawer', data: 'home');
                              } else if (arrTitles[index]
                                  .toLowerCase()
                                  .contains('calculator'.toLowerCase())) {
                                NotificationCenter().notify(
                                    'navigateFromDrawer',
                                    data: 'calculator');
                              } else if (arrTitles[index]
                                  .toLowerCase()
                                  .contains(
                                      'supported Projects'.toLowerCase())) {
                                Get.delete<StaticPageController>();
                                NotificationCenter().notify(
                                    'navigateFromDrawer',
                                    data: 'supportedProjects');
                                //   Get.to(() => StaticPage(),
                                // preventDuplicates: false);
                              } else if (arrTitles[index]
                                  .toLowerCase()
                                  .contains('contact'.toLowerCase())) {
                                NotificationCenter().notify(
                                    'navigateFromDrawer',
                                    data: 'contact us');
                              } else if (arrTitles[index]
                                  .toLowerCase()
                                  .contains('tips'.toLowerCase())) {
                                NotificationCenter()
                                    .notify('navigateFromDrawer', data: 'tips');
                              } else if (arrTitles[index]
                                  .toLowerCase()
                                  .contains('faqs'.toLowerCase())) {
                                NotificationCenter()
                                    .notify('navigateFromDrawer', data: 'faqs');
                              } else if (arrTitles[index]
                                  .toLowerCase()
                                  .contains('Privacy'.toLowerCase())) {
                                Get.delete<StaticPageController>();
                                NotificationCenter().notify(
                                    'navigateFromDrawer',
                                    data: 'privacy');
                                //   Get.to(() => StaticPage(),
                                // preventDuplicates: false);
                              } else if (arrTitles[index]
                                  .toLowerCase()
                                  .contains('terms'.toLowerCase())) {
                                Get.delete<StaticPageController>();
                                NotificationCenter().notify(
                                    'navigateFromDrawer',
                                    data: 'terms');
                                //   Get.to(() => StaticPage(),
                                // preventDuplicates: false);
                              } else if (arrTitles[index]
                                  .toLowerCase()
                                  .contains('about'.toLowerCase())) {
                                Get.delete<StaticPageController>();
                                NotificationCenter().notify(
                                    'navigateFromDrawer',
                                    data: 'about');
                                //   Get.to(() => StaticPage(),
                                // preventDuplicates: false);
                              }
                            },
                          );
                        },
                      )),
                      Container(
                        height: 120,
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            border: Border(
                                top: BorderSide(
                                    color: ColorStyle.greyColor_0E6E6E6,
                                    width: 1))),
                        child: ElevatedButtonCustom(
                          text: 'Logout',
                          width: MediaQuery.of(context).size.width,
                          height: 54,
                          colorBG: ColorStyle.redColor_0F15222,
                          style: TextStylesCustom.textStyles_16
                              .apply(color: Colors.white, fontWeightDelta: 2),
                          onTap: () {
                            logOut(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            Scaffold.of(context).closeDrawer();
          },
        ),
      ),
    );
  }
}
