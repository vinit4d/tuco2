import 'package:get_storage/get_storage.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';
import 'package:tuco2/Views/SplashScreenOne.dart';

import 'Views/BlogListing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'tuCO2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: ColorStyle.primaryColor_52BC7F.toMaterialColor()),
      // home: TipsAndSuggestions(),
      home: SplashScreenOne(),
    );
  }
}

/*
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tuco2/Components/TextFormFieldCustom.dart';
import 'package:tuco2/ExportFiles/ExportFilesAuth.dart';

import '../ExportFiles/ExportFilesMust.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String googleApikey = "AIzaSyANDsDeGl7DmtDWAsdi98MxwP0kVxDzbPI";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Search Location";

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Place Search Autocomplete Google Map"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: TextFormFieldLocationGooglePlaces(
          title: 'Hello',
          controller: controller,
          textStyleTitle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          textStyle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          onTap: (location) {
            print(location);
          }, // title: controller.arrTransformData[i]['label'],
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          // controller: controller.arrTextEditingController[i],
          radiusBorder: 4,
          // isStar: (controller.arrTransformData[i]['required'].toString() ==
          //     'true')
          //     ? true
          //     : false,
          // onTap: () {},
        ));
  }
}
*/
