import 'package:notification_center/notification_center.dart';
import 'package:tuco2/Controllers/ProfileController.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:tuco2/Views/TripScreen.dart';

import '../Views/Dashboard.dart';
import '../Views/DrawerCustom.dart';
import '../Views/Profile.dart';

RxInt selectedIndex = 0.obs;
// RxBool isTrailing = false.obs;
RxString currentPage = "Page1".obs;

class BottomNavBarCustom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavBarCustomState();
}

class BottomNavBarCustomState extends State<BottomNavBarCustom> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> pageKeys = ["Page1", "Page2", "Page3"];

  double iconSize = 24;

  Widget? appBar;

  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    // "Page4": GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 600), () {
      selectedIndex.value = 0;
      _selectTab(pageKeys[0], 0);
      NotificationCenter().subscribe('navigateFromDrawer', navigateFromDrawer);
    });
  }

  void navigateFromDrawer(String pageName) {
    if (pageName.toLowerCase().contains('home')) {
      _selectTab(pageKeys[0], 0);
    } else if (pageName.toLowerCase().contains('calculator')) {
      _selectTab(pageKeys[1], 1);
    } else {
      _selectTab(pageKeys[2], 2);
    }
  }

  void _selectTab(String tabItem, int index) {
    if (tabItem == currentPage.value) {
      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      final controller = Get.put(ProfileController());
      controller.initStateCustom();

      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);

      setState(() {
        currentPage.value = pageKeys[index];
        selectedIndex.value = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await navigatorKeys[currentPage.value]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentPage.value != "Page1") {
            _selectTab("Page1", 0);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Obx(
        () => Scaffold(
          body: Stack(children: <Widget>[
            _buildOffstageNavigator("Page1"),
            _buildOffstageNavigator("Page2"),
            _buildOffstageNavigator("Page3"),
            // _buildOffstageNavigator("Page4"),
          ]),
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBarStyle(
            isTrailing: false,
          ),
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: (selectedIndex.value == 0)
                          ? BoxDecoration(
                              color: ColorStyle.greyColor_02C2C2E,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            )
                          : BoxDecoration(),
                      height: 4,
                      width: 70,
                      alignment: Alignment.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _selectTab(pageKeys[0], 0);
                      },
                      child: Image.asset(
                        ImageStyle.home,
                        height: 30,
                        color: (selectedIndex.value == 0)
                            ? ColorStyle.primaryColor_52BC7F
                            : ColorStyle.greyColor_0A09F99,
                      ),
                    ),
                  ],
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       border: Border(
                //           top: (selectedIndex.value == 0)
                //               ? BorderSide(
                //                   color: ColorStyle.greyColor_02C2C2E, width: 3)
                //               : const BorderSide(
                //                   color: Colors.transparent, width: 3))),
                //   height: double.infinity,
                //   alignment: Alignment.center,
                //   child: InkWell(
                //     onTap: () {
                //       isTrailing.value = true;
                //       _selectTab(pageKeys[0], 0);
                //     },
                //     child: Image.asset(
                //       ImageStyle.home,
                //       height: 30,
                //       color: (selectedIndex.value == 0)
                //           ? ColorStyle.primaryColor_52BC7F
                //           : ColorStyle.greyColor_606060,
                //     ),
                //   ),
                // ),
                Column(
                  children: [
                    Container(
                      decoration: (selectedIndex.value == 1)
                          ? BoxDecoration(
                              color: ColorStyle.greyColor_02C2C2E,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            )
                          : BoxDecoration(),
                      height: 4,
                      width: 70,
                      alignment: Alignment.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _selectTab(pageKeys[1], 1);
                      },
                      child: Image.asset(
                        ImageStyle.calculator,
                        height: 30,
                        color: (selectedIndex.value == 1)
                            ? ColorStyle.primaryColor_52BC7F
                            : ColorStyle.greyColor_0A09F99,
                      ),
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Container(
                //       decoration: (selectedIndex.value == 2)
                //           ? BoxDecoration(
                //               color: ColorStyle.greyColor_02C2C2E,
                //               borderRadius: BorderRadius.circular(20),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey.withOpacity(0.3),
                //                   spreadRadius: 3,
                //                   blurRadius: 3,
                //                   offset: Offset(
                //                       0, 4), // changes position of shadow
                //                 ),
                //               ],
                //             )
                //           : BoxDecoration(),
                //       height: 4,
                //       width: 70,
                //       alignment: Alignment.center,
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         _selectTab(pageKeys[2], 2);
                //       },
                //       child: Image.asset(
                //         ImageStyle.notification,
                //         height: 30,
                //         color: (selectedIndex.value == 2)
                //             ? ColorStyle.primaryColor_52BC7F
                //             : ColorStyle.greyColor_0A09F99,
                //       ),
                //     )
                //   ],
                // ),

                InkWell(
                  onTap: () {
                    _selectTab(pageKeys[2], 2);
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: (selectedIndex.value == 2)
                            ? BoxDecoration(
                                color: ColorStyle.greyColor_02C2C2E,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 4), // changes position of shadow
                                  ),
                                ],
                              )
                            : BoxDecoration(),
                        height: 4,
                        width: 70,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: 44,
                          width: 44,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                color: ColorStyle.primaryColor_52BC7F,
                                width: 1,
                              )),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                avatar.value,
                                fit: BoxFit.fill,
                                errorBuilder: (context, url, error) =>
                                    Image.network(
                                  'https://media.glamourmagazine.co.uk/photos/62ea5ac396a3ad6877093558/1:1/w_1920,h_1920,c_limit/AMBER%20HEARD%20TIDE%20TURN%20030822%20default-sq-GettyImages-1154257098.jpg',
                                  height: 100,
                                  width: 100,
                                ),
                              )

                              // CachedNetworkImage(
                              //   fit: BoxFit.fill,
                              //   imageUrl: avatar.value,
                              //   progressIndicatorBuilder:
                              //       (context, url, downloadProgress) =>
                              //           CircularProgressIndicator(
                              //     value: downloadProgress.progress,
                              //     color: ColorStyle.primaryColor_52BC7F,
                              //     strokeWidth: 1.5,
                              //   ),
                              //   errorWidget: (context, url, error) => const Icon(
                              //     Icons.no_photography_outlined,
                              //     color: Colors.black,
                              //   ),
                              // ),
                              ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          drawer: DrawerCustom(),
          drawerScrimColor: Colors.transparent,
          drawerEnableOpenDragGesture: false,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage.value != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (tabItem == "Page1") {
      // child = const AddTransportation();
      // child = const TripScreen();
      child = DashboardScreen();
    } else if (tabItem == "Page2") {
      // child = const Calculator();
      child = TripScreen();
    } else if (tabItem == "Page3") {
      child = const Profile();
    }

    // else if (tabItem == "Page4") {
    //   child = const NotificationScreen();
    // }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child!);
      },
    );
  }
}
