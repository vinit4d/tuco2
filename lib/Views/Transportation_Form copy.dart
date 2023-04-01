import 'package:tuco2/Controllers/Transportation_FormController.dart';
import 'package:tuco2/ExportFiles/ExportFilesAuth.dart';

import '../Components/Dropdown.dart';
import '../Components/TransportationComponents.dart';
import '../ExportFiles/ExportFilesMust.dart';

class Transportation_Form extends StatefulWidget {
  const Transportation_Form({Key? key}) : super(key: key);

  @override
  State<Transportation_Form> createState() => _Transportation_FormState();
}

class _Transportation_FormState extends State<Transportation_Form> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCarbonNeutral = 'Select a value';

  String? selectedClass = 'Select a class';
  String? selectedRoundTrip = 'Select the round trip';

  List<String> arrCarbonNeutral = [
    'Yes',
    'No',
  ];

  List<String> arrClass = ['Business', 'Economy', 'General'];
  List<String> arrRoundTrip = [
    'Yes',
    'No',
  ];

  TextEditingController controllerCarbonNuetral = TextEditingController();
  TextEditingController controllerClass = TextEditingController();
  TextEditingController controllerRoundTrip = TextEditingController();

  final controller = Get.put(Transportation_FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: GetBuilder(
        init: Transportation_FormController(),
        initState: (_) {
          controller.initCustom();
        },
        builder: (_) {
          return Container(
            margin: const EdgeInsets.only(top: 140),
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                )),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 4,
                    width: 80,
                    decoration: BoxDecoration(
                        color: ColorStyle.greyColor_0E6E6E6,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PopupMenuCustom(
                    title: 'Is flight carbon neutral?',
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 6,
                      bottom: 6,
                    ),
                    selectedText: selectedCarbonNeutral,
                    isStar: true,
                    hintText: 'Please select a carbon neutral status',
                    list: arrCarbonNeutral,
                    colorBorder: ColorStyle.greyColor_0E6E6E6,
                    colorHint: ColorStyle.greyColor_999999,
                    colorText: Colors.red,
                    controller: controllerCarbonNuetral,
                    textStyle: TextStylesCustom.textStyles_15.apply(
                      color: ColorStyle.redColor_0F15222,
                      fontWeightDelta: 2,
                    ),
                    validator: (value) => ValidatorTransportation.isValid(
                        'Please select a carbon neutral status', value!),
                    onChanged: (index) {
                      selectedCarbonNeutral = arrCarbonNeutral[index];
                      controllerCarbonNuetral.text = selectedCarbonNeutral!;
                      controllerCarbonNuetral;

                      _formKey.currentState!.validate();

                      setState(() {});
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TransportationComponents.textFormFieldWithTitle(
                          title: 'Via (1)',
                          isStar: false,
                          hint: 'Enter via 1',
                          validator: (value) => ValidatorTransportation.isValid(
                              'Enter you via 1', value!),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TransportationComponents.textFormFieldWithTitle(
                          title: 'Via (2)',
                          isStar: false,
                          hint: 'Enter via 2',
                          validator: (value) => ValidatorTransportation.isValid(
                              'Enter you via 2', value!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: PopupMenuCustom(
                        title: 'Class',
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 6,
                          bottom: 6,
                        ),
                        selectedText: selectedClass,
                        isStar: true,
                        hintText: 'Please select a class',
                        list: arrClass,
                        colorBorder: ColorStyle.greyColor_0E6E6E6,
                        colorHint: ColorStyle.greyColor_999999,
                        colorText: Colors.red,
                        controller: controllerClass,
                        textStyle: TextStylesCustom.textStyles_15.apply(
                          color: ColorStyle.redColor_0F15222,
                          fontWeightDelta: 2,
                        ),
                        validator: (value) => ValidatorTransportation.isValid(
                            'Please select this one', value!),
                        onChanged: (index) {
                          selectedClass = arrClass[index];

                          controllerClass.text = selectedClass!;

                          _formKey.currentState!.validate();

                          setState(() {});
                        },
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: PopupMenuCustom(
                        title: 'Round trip',
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 6,
                          bottom: 6,
                        ),
                        selectedText: selectedRoundTrip,
                        isStar: true,
                        hintText: 'Please select this one',
                        list: arrRoundTrip,
                        colorBorder: ColorStyle.greyColor_0E6E6E6,
                        colorHint: ColorStyle.greyColor_999999,
                        colorText: Colors.red,
                        controller: controllerRoundTrip,
                        textStyle: TextStylesCustom.textStyles_15.apply(
                          color: ColorStyle.redColor_0F15222,
                          fontWeightDelta: 2,
                        ),
                        validator: (value) => ValidatorTransportation.isValid(
                            'Please select this one', value!),
                        onChanged: (index) {
                          selectedRoundTrip = arrRoundTrip[index];
                          controllerRoundTrip.text = selectedRoundTrip!;
                          // _formKey.currentState!.validate();

                          setState(() {});
                        },
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButtonLoadingCustom(
                    keyCustom: 'Save',
                    text: 'Save',
                    width: MediaQuery.of(context).size.width,
                    colorBG: ColorStyle.primaryColor_52BC7F,
                    style: TextStylesCustom.textStyles_16
                        .apply(color: Colors.white, fontWeightDelta: 3),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
