import 'package:get_storage/get_storage.dart';

import '../ExportFiles/ExportFilesMust.dart';
import 'Login.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({Key? key}) : super(key: key);

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    navigate();
  }

  navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (autoLogin()) {
        Get.offAll(BottomNavBarCustom());
      } else {
        Get.offAll(Login());
      }
    });
  }

  bool autoLogin() {
    final getStorage = GetStorage();
    debugPrint(getStorage.read('user'));

    if (getStorage.read('user') == null) {
      return false;
    } else {
      final user = getStorage.read('user').toString();
      if (user.isEmpty) {
        return false;
      } else {
        // final dictUser = jsonEncode(user);
        // print(dictUser);

        dictData = Map<String, dynamic>.from(jsonDecode(user));
        print(dictData);

        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Image.asset(
            ImageStyle.splashBGUpper,
            fit: BoxFit.fill,
            width: double.infinity,
            height: 500,
          )),
          SizedBox(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageStyle.logoWithNamePNG,
                  width: 220,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Calculate and Offset your",
                  style: TextStylesCustomPoppins.textStyles_14.apply(
                    color: ColorStyle.greyColor_606060,
                    // fontWeightDelta: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Travel Carbon Footprint",
                  style: TextStylesCustomPoppins.textStyles_18.apply(
                      color: ColorStyle.greyColor_606060, fontWeightDelta: 2),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 0),
                  child: Image.asset(
                    ImageStyle.splashBGBottom,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 160,
                  )),
              Positioned(
                bottom: 20,
                left: 20,
                right: 0,
                child: Text(
                  "Let's make Sustainable Travel \nour way of life!",
                  style: TextStylesCustomPoppins.textStyles_16.apply(
                    color: ColorStyle.greyColor_606060,
                    // fontWeightDelta: 1
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
