import 'package:flutter_svg/svg.dart';
import 'package:tuco2/Controllers/TripScreenController.dart';

import '../Components/Dropdown.dart';
import '../Components/PickerCustom.dart';
import '../Components/TextFormFieldCustom.dart';
import '../ExportFiles/ExportFilesMust.dart';
import '../Utils/ValidatorAuth.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(TripScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder(
          init: TripScreenController(),
          initState: (_) {
            Future.delayed(const Duration(milliseconds: 800), () {
              controller.initCustom();
            });
          },
          builder: (_) {
            return Obx(() => SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 40,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Let's start!",
                          style: TextStylesCustomPoppins.textStyles_24.apply(
                            fontWeightDelta: 5,
                            color: ColorStyle.primaryColor_52BC7F,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Enter your overall journey information."
                          "On the next step, you will insert details"
                          "regarding all interim legs and stops.",
                          style: TextStylesCustom.textStyles_16.apply(
                            fontWeightDelta: 4,
                            color: ColorStyle.greyColor_606060,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                left: 0,
                                right: 16,
                              ),
                              margin: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorStyle.redColor_0F15222,
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    width: 14,
                                    height: 14,
                                  ),
                                  Image.asset(
                                    ImageStyle.line_Dotted,
                                    height: 80,
                                    // width: 2,
                                    // color: ColorStyle.greyColor_0E3E3E1,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorStyle.greenColor_52BC7F,
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    width: 14,
                                    height: 14,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                TextFormFieldLocationGooglePlaces(
                                  textStyleTitle: TextStylesCustom.textStyles_16
                                      .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3),
                                  textStyle: TextStylesCustom.textStyles_16
                                      .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3),
                                  onTap: (location) {
                                    print(location);

                                    controller.controllerFrom.value.text =
                                        location;
                                  },
                                  title: 'From',
                                  colorBorder: ColorStyle.greyColor_0E6E6E6,
                                  controller: controller.controllerFrom.value,
                                  radiusBorder: 4,
                                  isStar: true,
                                  validator: (value) =>
                                      ValidatorTransportation.isValid(
                                          'Please enter source location',
                                          value!),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormFieldLocationGooglePlaces(
                                  textStyleTitle: TextStylesCustom.textStyles_16
                                      .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3),
                                  textStyle: TextStylesCustom.textStyles_16
                                      .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3),
                                  onTap: (location) {
                                    print(location);
                                    controller.controllerTo.value.text =
                                        location;
                                  },
                                  title: 'Destination',
                                  colorBorder: ColorStyle.greyColor_0E6E6E6,
                                  controller: controller.controllerTo.value,
                                  radiusBorder: 4,
                                  isStar: true,
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 10),
                                  maxLines: 2,
                                  validator: (value) =>
                                      ValidatorTransportation.isValid(
                                          'Please enter destination location',
                                          value!),
                                ),
                              ],
                            )),
                            Container(
                              // color: Colors.black12,
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 0,
                              ),
                              margin: const EdgeInsets.only(top: 20),
                              child: Image.asset(
                                (controller.controllerRoundTrip.value.text
                                            .toLowerCase() ==
                                        'yes'.toLowerCase())
                                    ? ImageStyle.tripRound
                                    : ImageStyle.tripRoundNot,
                                width: 50,
                                // height: 100,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: PopupMenuCustom(
                              title: 'Round trip',
                              textStyleTitle:
                                  TextStylesCustom.textStyles_16.apply(
                                color: ColorStyle.greyColor_606060,
                                fontWeightDelta: 4,
                              ),
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 6,
                                bottom: 6,
                              ),
                              selectedText: controller.selectedRoundTrip.value,
                              isStar: true,
                              hintText: 'No',
                              list: controller.arrRoundTrip.value,
                              colorBorder: ColorStyle.greyColor_0E6E6E6,
                              colorHint: Colors.black,
                              colorText: Colors.red,
                              controller: controller.controllerRoundTrip.value,
                              radiusBorder: 4,
                              textStyle: TextStylesCustom.textStyles_15.apply(
                                color: ColorStyle.greyColor_606060,
                                fontWeightDelta: 3,
                              ),
                              validator: (value) =>
                                  ValidatorTransportation.isValid(
                                      'Please select round trip', value!),
                              onChanged: (index) {
                                controller.selectedRoundTrip.value =
                                    controller.arrRoundTrip[index];
                                controller.controllerRoundTrip.value.text =
                                    controller.selectedRoundTrip.value;

                                _formKey.currentState!.validate();
                              },
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              width: 140,
                              child: PlusMinusComponents(
                                title: 'Passengers',
                                textStyleTitle:
                                    TextStylesCustom.textStyles_16.apply(
                                  color: ColorStyle.greyColor_606060,
                                  fontWeightDelta: 3,
                                ),
                                isStar: true,
                                height: 48,
                                onTap: (value) {
                                  controller.passengers = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: TextFormFieldDatePicker(
                              title: 'Start Date',
                              textStyleTitle:
                                  TextStylesCustom.textStyles_16.apply(
                                color: ColorStyle.greyColor_606060,
                                fontWeightDelta: 3,
                              ),
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 6,
                                bottom: 6,
                              ),
                              isStar: true,
                              hintText: 'Select a date',
                              // list: arrCarbonNeutral,
                              colorBorder: ColorStyle.greyColor_0E6E6E6,
                              colorHint: ColorStyle.greyColor_999999,
                              colorText: Colors.red,
                              radiusBorder: 4,
                              controller: controller.controllerStartDates.value,
                              textStyle: TextStylesCustom.textStyles_15.apply(
                                color: ColorStyle.greyColor_606060,
                                fontWeightDelta: 3,
                              ),
                              validator: (value) =>
                                  ValidatorTransportation.isValid(
                                      'Please select start date', value!),
                              onTap: () async {
                                final selectedDate =
                                    await PickerCustom.datePicker(
                                        'do MMMM, yyyy');

                                if (selectedDate != null) {
                                  controller.controllerStartDates.value.text =
                                      selectedDate.toString();
                                }
                              },
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              width: 140,
                              child: PlusMinusComponents(
                                title: 'Total trip days',
                                textStyleTitle:
                                    TextStylesCustom.textStyles_16.apply(
                                  color: ColorStyle.greyColor_606060,
                                  fontWeightDelta: 4,
                                ),
                                isStar: true,
                                height: 48,
                                onTap: (value) {
                                  controller.totalTripDays = value;
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.transparent,
                          height: 32,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButtonLoadingCustom(
                            keyCustom: 'Continue',
                            text: 'Continue',
                            height: 54,
                            width: MediaQuery.of(context).size.width - 100,
                            colorBG: ColorStyle.primaryColor_52BC7F,
                            style: TextStylesCustom.textStyles_16
                                .apply(color: Colors.white, fontWeightDelta: 3),
                            // isLoading: false,
                            isLoading: controller.isLoading.value,
                            onTap: () {
                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                debugPrint('Login is tapping ...');

                                controller.continueButton(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}

class PlusMinusComponents extends StatefulWidget {
  const PlusMinusComponents({
    Key? key,
    this.isStar = false,
    this.title = 'Title',
    this.textStyleTitle = const TextStyle(fontSize: 16, color: Colors.red),
    this.height = 48,
    this.onTap,
  }) : super(key: key);

  final String? title;
  final TextStyle? textStyleTitle;
  final bool? isStar;
  final double? height;
  final Function(String)? onTap;

  @override
  State<PlusMinusComponents> createState() => _PlusMinusComponentsState();
}

class _PlusMinusComponentsState extends State<PlusMinusComponents> {
  int number = 1;
  String numberString = '01';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title!,
              textAlign: TextAlign.left,
              style: widget.textStyleTitle,
              // style: TextStylesCustom.textStyles_14.apply(
              //   color: widget.colorHint,
              //   fontWeightDelta: 1,
              // ),
            ),
            if (widget.isStar!)
              Text(
                '*',
                textAlign: TextAlign.left,
                style: TextStylesCustom.textStyles_15.apply(
                  color: ColorStyle.redColor_0F15222,
                  fontWeightDelta: 2,
                ),
              )
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          height: widget.height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border:
                  Border.all(color: ColorStyle.greyColor_0E6E6E6, width: 1)),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    if (number != 1) {
                    number -= 1;
                  }

                  debugPrint(number.toString().length.toString());

                  numberString = (number.toString().length == 1)
                      ? '0$number'
                      : number.toString();

                  widget.onTap!(numberString);
                  setState(() {});
                  },
                  child: Container(
                    height: 2,
                    width: 12,
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: SvgPicture.asset(ImageStyle.minusIconSVG,
                    fit: BoxFit.fill,),
                  ),),
              // IconButton(
              //   icon: Icon(
              //     Icons.remove,
              //     size: 20,
              //     color: ColorStyle.greyColor_0A09F99,
              //   ),
              // onPressed: () {
              //   if (number != 1) {
              //     number -= 1;
              //   }

              //   debugPrint(number.toString().length.toString());

              //   numberString = (number.toString().length == 1)
              //       ? '0$number'
              //       : number.toString();

              //   widget.onTap!(numberString);
              //   setState(() {});
              // },
              // ),
              // SvgPicture.asset(
              //   ImageStyle.minusSVG,
              //   height: 100,
              // ),
              Expanded(
                // child: FittedBox(
                child: Text(numberString,
                    textAlign: TextAlign.center,
                    style: TextStylesCustom.textStyles_16.apply(
                        color: ColorStyle.greyColor_606060,
                        fontWeightDelta: 3)),
                // )
              ),

              InkWell(
                onTap: (){
                       if (number < 20) {
                    number += 1;
                  }

                  debugPrint(number.toString().length.toString());

                  numberString = (number.toString().length == 1)
                      ? '0$number'
                      : number.toString();

                  widget.onTap!(numberString);
                  setState(() {});
                },
                child:  Container(
                    height: 12,
                    width: 12,
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: SvgPicture.asset(ImageStyle.plusIconSVG
                    
                    ),
                  ),
              )
              // IconButton(
              //   icon: Icon(
              //     Icons.add,
              //     size: 20,
              //     color: ColorStyle.greyColor_0A09F99,
              //   ),
              //   onPressed: () {
              //     if (number < 20) {
              //       number += 1;
              //     }

              //     debugPrint(number.toString().length.toString());

              //     numberString = (number.toString().length == 1)
              //         ? '0$number'
              //         : number.toString();

              //     widget.onTap!(numberString);
              //     setState(() {});
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
