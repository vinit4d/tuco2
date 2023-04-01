import 'package:tuco2/Controllers/Transportation_FormController.dart';
import 'package:tuco2/ExportFiles/ExportFilesAuth.dart';

import '../Components/Dropdown.dart';
import '../Components/TransportationComponents.dart';
import '../ExportFiles/ExportFilesMust.dart';

hello() {
  Get.bottomSheet(
    Container(),
    isDismissible: true,
    ignoreSafeArea: true,
    isScrollControlled: true,
  );
}

showTransportation_Form(String transportID, String tripID,
    {List<Map<String, dynamic>>? arrTransformData,
    String? transportationTripID}) {
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(Transportation_FormController());

  formFields() {
    List<Widget> arrFormFields = [];

    final widthCustom = MediaQuery.of(Get.context!).size.width - 32;

    final hello = controller.arrTransformData;
    debugPrint(hello.toString());

    for (int i = 0; i < controller.arrTransformData.length; i++) {
      controller.arrTextEditingController.add(TextEditingController());
      controller.arrValuesContainerSelected.add("");
    }

    for (int i = 0; i < controller.arrTransformData.length; i++) {
      final widthFinal = (controller.arrTransformData[i]['width'] == 'w-full')
          ? widthCustom
          : (widthCustom / 2) - 10;

      final typeString = controller.arrTransformData[i]['type'];
      final subTypeString = controller.arrTransformData[i]['subtype'];

      if (typeString == 'text' && subTypeString == null) {
        arrFormFields.add(SizedBox(
          width: widthFinal,
          child: TransportationComponents.textFormFieldWithTitle(
            title: controller.arrTransformData[i]['label'],
            isStar: (controller.arrTransformData[i]['required'].toString() ==
                    'true')
                ? true
                : false,
            hint:
                controller.arrTransformData[i]['placeholder'] ?? 'placeholder',
            controller: controller.arrTextEditingController[i],
            validator: (value) => ValidatorTransportation.isValid(
                'Enter ${controller.arrTransformData[i]['label'].toString().toLowerCase()}',
                value!),
          ),
        ));
      } else if (typeString == 'select' && subTypeString == null) {
        List<String> arrLabels = [];
        List<String> arrValues = [];

        arrLabels.clear();
        arrValues.clear();

        final arrValueAllData = List<Map<String, dynamic>>.from(
            controller.arrTransformData[i]['values']);

        for (int i = 0; i < arrValueAllData.length; i++) {
          final strLabel = arrValueAllData[i]['label'].toString();
          arrLabels.add(strLabel);

          final strValues = arrValueAllData[i]['value'].toString();

          arrValues.add(strValues);
        }

        controller.arrTextEditingController[i].text = arrLabels[0];
controller.arrValuesContainerSelected[i] = arrValues[0];
        arrFormFields.add(SizedBox(
          width: widthFinal,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              PopupMenuCustom(
                title: controller.arrTransformData[i]['label']
                    .toString()
                    .stringUnscape(),
                width: widthFinal,
                textStyleTitle: TextStylesCustom.textStyles_16.apply(
                  color: ColorStyle.greyColor_606060,
                  fontWeightDelta: 3,
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 6,
                  bottom: 6,
                ),
                selectedText: arrLabels[0],
                isStar: true,
                // hintText:
                //     controller.arrTransformData[i]['placeholder'] ?? 'placeholder',
                list: arrLabels,
                colorBorder: ColorStyle.greyColor_0E6E6E6,
                colorHint: ColorStyle.greyColor_999999,
                colorText: Colors.red,
                controller: controller.arrTextEditingController[i],
                textStyle: TextStylesCustom.textStyles_16.apply(
                  color: ColorStyle.greyColor_606060,
                  fontWeightDelta: 3,
                ),
                radiusBorder: 4,
                validator: (value) => ValidatorTransportation.isValid(
                    'Please select ${controller.arrTransformData[i]['label'].toString().toLowerCase()}',
                    value!),
                onChanged: (index) {
                  controller.arrTextEditingController[i].text =
                  arrLabels[index];

                  controller.arrValuesContainerSelected[i] =
                  arrValues[index];

                  // debugPrint(
                  //     controller.arrTextEditingController[i].text.toString());

                  // Future.delayed(const Duration(milliseconds: 100), () {
                  //   _formKey.currentState!.reset();
                  // });
                },
              )
            ],
          ),
        ));
      } else if (typeString == 'text' && subTypeString == 'location') {
        arrFormFields.add(SizedBox(
          width: widthFinal,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TextFormFieldLocationGooglePlaces(
              textStyleTitle: TextStylesCustom.textStyles_16.apply(
                  color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
              textStyle: TextStylesCustom.textStyles_16.apply(
                  color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
              onTap: (location) {
                print(location);

                controller.arrTextEditingController[i].text = location;

                controller.arrValuesContainerSelected[i] = location;
              },
              title: controller.arrTransformData[i]['label'],
              colorBorder: ColorStyle.greyColor_0E6E6E6,
              controller: controller.arrTextEditingController[i],
              radiusBorder: 4,
              isStar: (controller.arrTransformData[i]['required'].toString() ==
                      'true')
                  ? true
                  : false,
              hintText: controller.arrTransformData[i]['placeholder'] ??
                  'placeholder',
              validator: (value) => (controller.arrTransformData[i]['required']
                          .toString() ==
                      'true')
                  ? ValidatorTransportation.isValid(
                      'Please enter ${controller.arrTransformData[i]['label'].toString().toLowerCase()} location',
                      value!)
                  : null,
            ),
          ),
        ));
      }
    }

    return arrFormFields;
  }

  Get.bottomSheet(
    GetBuilder(
      init: Transportation_FormController(),
      initState: (_) {
        controller.transportID = transportID;

        if (arrTransformData == null) {
          controller.initCustom();
        } else {
          controller.arrTransformData.clear();
          controller.arrTextEditingController.clear();

          controller.arrTransformData.value = arrTransformData;

          for (int i = 0; i < controller.arrTransformData.length; i++) {
            final textEditController = TextEditingController();

            // final hello = controller.arrTransformData[i]['value'] ?? '';

            textEditController.text =
                controller.arrTransformData[i]['value'] ?? '';

            controller.arrTextEditingController.add(textEditController);
          }

          controller.update();
        }
      },
      builder: (_) {
        return Obx(() => GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                // constraints: BoxConstraints(
                //   maxHeight: MediaQuery.of(Get.context!).size.height - 140,
                // ),
                height: MediaQuery.of(Get.context!).size.height - 140,
                // margin: const EdgeInsets.only(top: 140),
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
                child: controller.isLoadingFetch.value
                    ? loader()
                    : Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Divider(
                              color: Colors.transparent,
                              height: 25,
                            ),
                            Container(
                              height: 4,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: ColorStyle.greyColor_0E6E6E6,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            const Divider(
                              color: Colors.transparent,
                              height: 25,
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: 16, // Horizontal space.
                                    // runSpacing: 30.0, // Vertical space.
                                    children: formFields(),
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                  ),
                                  const Divider(
                                    color: Colors.transparent,
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: ElevatedButtonLoadingCustom(
                                      keyCustom: 'Save',
                                      text: 'Save',
                                      width: MediaQuery.of(Get.context!)
                                          .size
                                          .width,
                                      colorBG: ColorStyle.primaryColor_52BC7F,
                                      style: TextStylesCustom.textStyles_16
                                          .apply(
                                              color: Colors.white,
                                              fontWeightDelta: 3),
                                      // isLoading: false,
                                      isLoading: controller.isLoading.value,
                                      onTap: () {
                                        FocusScope.of(Get.context!).unfocus();

                                        if (_formKey.currentState!.validate()) {
                                          debugPrint('Login is tapping ...');

                                          controller.saveButton(tripID,
                                              transportationTripID:
                                                  transportationTripID);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
              ),
            ));
      },
    ),
    isDismissible: true,
    ignoreSafeArea: true,
    isScrollControlled: true,
  );

  /*
  Get.bottomSheet(
    GetBuilder(
      init: Transportation_FormController(),
      initState: (_) {
        controller.transportID = transportID;

        if (arrTransformData == null) {
          controller.initCustom();
        } else {
          controller.arrTransformData.clear();
          controller.arrTextEditingController.clear();

          controller.arrTransformData.value = arrTransformData;

          for (int i = 0; i < controller.arrTransformData.length; i++) {
            final textEditController = TextEditingController();

            // final hello = controller.arrTransformData[i]['value'] ?? '';

            textEditController.text =
                controller.arrTransformData[i]['value'] ?? '';

            controller.arrTextEditingController.add(textEditController);
          }

          controller.update();
        }
      },
      builder: (_) {
        return GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            // constraints: BoxConstraints(
            //   maxHeight: MediaQuery.of(Get.context!).size.height - 140,
            // ),
            height: MediaQuery.of(Get.context!).size.height - 140,
            // margin: const EdgeInsets.only(top: 140),
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
            child: controller.isLoadingFetch.value
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Divider(
                          color: Colors.transparent,
                          height: 25,
                        ),
                        Container(
                          height: 4,
                          width: 100,
                          decoration: BoxDecoration(
                              color: ColorStyle.greyColor_0E6E6E6,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        const Divider(
                          color: Colors.transparent,
                          height: 25,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: Column(
                            children: [
                              Wrap(
                                spacing: 16, // Horizontal space.
                                // runSpacing: 30.0, // Vertical space.
                                children: formFields(),
                                crossAxisAlignment: WrapCrossAlignment.end,
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: ElevatedButtonLoadingCustom(
                                  keyCustom: 'Save',
                                  text: 'Save',
                                  width: MediaQuery.of(Get.context!).size.width,
                                  colorBG: ColorStyle.primaryColor_52BC7F,
                                  style: TextStylesCustom.textStyles_16.apply(
                                      color: Colors.white, fontWeightDelta: 3),
                                  // isLoading: false,
                                  isLoading: controller.isLoading.value,
                                  onTap: () {
                                    FocusScope.of(Get.context!).unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      debugPrint('Login is tapping ...');

                                      controller.saveButton(tripID,
                                          transportationTripID:
                                              transportationTripID);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                : loader(),
          ),
        );
      },
    ),
    isDismissible: true,
    ignoreSafeArea: true,
    isScrollControlled: true,
  );


   */
}
