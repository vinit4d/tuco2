import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:tuco2/Components/CreditCard/PaymentComponents.dart';
import 'package:tuco2/Controllers/DonationBillingController.dart';

import '../../ExportFiles/ExportFilesAuth.dart';
import '../../ExportFiles/ExportFilesMust.dart';

class DonationBilling extends StatefulWidget {
  const DonationBilling(
      {Key? key, required this.projectID, required this.price})
      : super(key: key);

  final String projectID;
  final String price;

  @override
  State<DonationBilling> createState() => _DonationBillingState();
}

class _DonationBillingState extends State<DonationBilling> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode focusNodePhoneNumber = FocusNode();
  final FocusNode focusNodeCardNumber = FocusNode();
  final FocusNode focusNodeExpiry = FocusNode();
  final FocusNode focusNodeCardCode = FocusNode();

  billingDetailsForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: AuthScreenComponents.textFormFieldWithTitleWithoutPrefix(
              title: 'First Name',
              isStar: true,
              hint: 'Enter your first name',
              prefixIcon: Image.asset(ImageStyle.user),
              controller: controller.firstName.value,
              validator: (value) => ValidatorAuth.firstName(value!),
              // onChanged: (value) {
              //   _formKey.currentState!.validate();
              // }
            )),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: AuthScreenComponents.textFormFieldWithTitleWithoutPrefix(
              title: 'Last Name',
              isStar: true,
              hint: 'Enter your last name',
              prefixIcon: Image.asset(ImageStyle.user),
              controller: controller.lastName.value,
              validator: (value) => ValidatorAuth.lastName(value!),

              // onChanged: (value) {
              //   _formKey.currentState!.validate();
              // }
            )),
          ],
        ),
        const Divider(
          color: Colors.transparent,
          height: 20,
        ),
        TextFormFieldLocation(
          textStyleTitle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          textStyle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          onTap: () {},
          title: 'Country/Region',
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          radiusBorder: 4,
          isStar: true,
          controller: controller.countryRegion.value,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return 'Enter country/region';
            }
            return null;
          },
        ),
        const Divider(
          color: Colors.transparent,
          height: 20,
        ),
        TextFormFieldLocation(
          controller: controller.state.value,
          textStyleTitle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          textStyle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          onTap: () {},
          title: 'State(optional)',
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          radiusBorder: 4,
          isStar: false,
        ),
        const Divider(
          color: Colors.transparent,
          height: 20,
        ),
        TextFormFieldLocation(
          controller: controller.townCity.value,
          textStyleTitle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          textStyle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          onTap: () {},
          title: 'Town / City',
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          radiusBorder: 4,
          isStar: true,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return 'Enter town/city';
            }
            return null;
          },
        ),
        const Divider(
          color: Colors.transparent,
          height: 20,
        ),
        TextFormFieldLocation(
          controller: controller.streetAddress.value,
          textStyleTitle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          textStyle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          onTap: () {},
          title: 'Street Address',
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          radiusBorder: 4,
          isStar: true,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return 'Enter street address';
            }
            return null;
          },
        ),
        const Divider(
          color: Colors.transparent,
          height: 20,
        ),
        TextFormFieldLocation(
          controller: controller.postCodeZip.value,
          textStyleTitle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          textStyle: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
          onTap: () {},
          title: 'Postcode/ZIP',
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          radiusBorder: 4,
          isStar: true,
          keyboardType: TextInputType.number,
          focusNode: focusNodePhoneNumber,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return 'Enter postcode/zip';
            } else if (value.trim().length < 5) {
              return 'Postcode/zip code at least 6 digits';
            }
            return null;
          },
        ),
      ],
    );
  }

  billingDetailsShow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Image.asset(
              ImageStyle.user,
              height: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Text(
              'Irma Hudson',
              style: TextStylesCustom.textStyles_14.apply(
                  color: ColorStyle.greyColor_606060, fontWeightDelta: 2),
            ))
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'Address',
          style: TextStylesCustom.textStyles_16
              .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Image.asset(
              ImageStyle.location,
              height: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Text(
              '162 Throop Ave, Brooklyn, NY 11206, USA',
              style: TextStylesCustom.textStyles_14.apply(
                  color: ColorStyle.greyColor_606060, fontWeightDelta: 2),
            ))
          ],
        ),
      ],
    );
  }

  final controller = Get.put(DonationBillingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: DonationBillingController(),
        initState: (_) {
          controller.projectID = widget.projectID;
          controller.price = widget.price;
          // controller.isLoadingBillingData.value = false;
          //
          // controller.update();

          Future.delayed(const Duration(milliseconds: 100), () {
            controller.initCustom();
          });
        },
        builder: (_) {
          return Obx(() => GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: KeyboardActions(
                  config: KeyboardActionsConfig(
                      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                      keyboardBarColor: Colors.grey[200],
                      actions: [
                        KeyboardActionsItem(
                            focusNode: focusNodePhoneNumber,
                            displayArrows: false,
                            toolbarButtons: [
                              (node) {
                                return GestureDetector(
                                  onTap: () => node.unfocus(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      'Done',
                                      style: TextStylesCustom.textStyles_16
                                          .apply(
                                              color: Colors.black,
                                              fontWeightDelta: 3),
                                    ),
                                  ),
                                );
                              }
                            ]),
                        KeyboardActionsItem(
                            focusNode: focusNodeCardNumber,
                            displayArrows: false,
                            toolbarButtons: [
                              (node) {
                                return GestureDetector(
                                  onTap: () => node.unfocus(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      'Done',
                                      style: TextStylesCustom.textStyles_16
                                          .apply(
                                              color: Colors.black,
                                              fontWeightDelta: 3),
                                    ),
                                  ),
                                );
                              }
                            ]),
                        KeyboardActionsItem(
                            focusNode: focusNodeExpiry,
                            displayArrows: false,
                            toolbarButtons: [
                              (node) {
                                return GestureDetector(
                                  onTap: () => node.unfocus(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      'Done',
                                      style: TextStylesCustom.textStyles_16
                                          .apply(
                                              color: Colors.black,
                                              fontWeightDelta: 3),
                                    ),
                                  ),
                                );
                              }
                            ]),
                        KeyboardActionsItem(
                            focusNode: focusNodeCardCode,
                            displayArrows: false,
                            toolbarButtons: [
                              (node) {
                                return GestureDetector(
                                  onTap: () => node.unfocus(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      'Done',
                                      style: TextStylesCustom.textStyles_16
                                          .apply(
                                              color: Colors.black,
                                              fontWeightDelta: 3),
                                    ),
                                  ),
                                );
                              }
                            ]),
                      ]),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: Colors.transparent,
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Billing details',
                                style: TextStylesCustom.textStyles_24.apply(
                                  color: ColorStyle.greyColor_606060,
                                  fontWeightDelta: 3,
                                ),
                              ),
                              if (controller.isUpdate.value)
                                InkWell(
                                  child: Image.asset(
                                    ImageStyle.edit,
                                    height: 24,
                                  ),
                                  onTap: () {
                                    controller.isUpdate.value = false;
                                  },
                                )
                            ],
                          ),
                          const Divider(
                            color: Colors.transparent,
                            height: 16,
                          ),
                          if (!controller.isLoadingBillingData.value)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (controller.isUpdate.value)
                                  billingDetailsShow()
                                else
                                  billingDetailsForm(),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Your donation',
                                  style: TextStylesCustom.textStyles_24.apply(
                                    color: ColorStyle.greyColor_606060,
                                    fontWeightDelta: 3,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                      color: ColorStyle.primaryColor_52BC7F,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Project',
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: Colors.white,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                      Text(
                                        'Subtotal',
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: Colors.white,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Image.asset(
                                          ImageStyle.donation,
                                          height: 60,
                                          width: 60,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Bundled wind power project at Satara, Maharashtra',
                                            maxLines: 3,
                                            style: TextStylesCustom
                                                .textStyles_14
                                                .apply(
                                              color:
                                                  ColorStyle.greyColor_606060,
                                              fontWeightDelta: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                    Container(
                                      width: 100,
                                      alignment: Alignment.center,
                                      // color: Colors.red,
                                      child: Text(
                                        '${widget.price} €',
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Want to add a discount coupon?',
                                      style:
                                          TextStylesCustom.textStyles_14.apply(
                                        color: ColorStyle.greyColor_606060,
                                        fontWeightDelta: 2,
                                      ),
                                    )),
                                    InkWell(
                                      child: Container(
                                        width: 100,
                                        alignment: Alignment.center,
                                        // color: Colors.red,
                                        child: Text(
                                          controller.isCoupon.value
                                              ? 'Remove'
                                              : 'Add here',
                                          style: TextStylesCustom.textStyles_16
                                              .apply(
                                            color: ColorStyle.redColor_0F15222,
                                            fontWeightDelta: 3,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        controller.isCouponMethod();
                                      },
                                    ),
                                  ],
                                ),
                                if (controller.isCoupon.value)
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormFieldCustom(
                                        textStyle: TextStylesCustom
                                            .textStyles_16
                                            .apply(
                                          color: ColorStyle.redColor_0F15222,
                                          fontWeightDelta: 2,
                                        ),
                                        colorBorder:
                                            ColorStyle.greyColor_0E6E6E6,
                                        radiusBorder: 4,
                                        hintText: 'Enter coupon code',
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 16,
                                          bottom: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  height: 1,
                                  color: ColorStyle.greyColor_0E6E6E6,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 100,
                                      alignment: Alignment.center,
                                      // color: Colors.red,
                                      child: Text(
                                        'Total',
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      alignment: Alignment.center,
                                      // color: Colors.red,
                                      child: Text(
                                        '${widget.price} €',
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  'Cards accepted: Visa, MasterCard, Maestro, Amex and more.',
                                  maxLines: 3,
                                  style: TextStylesCustom.textStyles_14.apply(
                                    color: ColorStyle.greyColor_0A09F99,
                                    fontWeightDelta: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Image.asset(ImageStyle.cardsList),
                                const SizedBox(
                                  height: 16,
                                ),
                                AuthScreenComponents.textFormFieldWithTitle(
                                  controller: controller.cardHolderName.value,
                                  title: 'Card holder name',
                                  isStar: true,
                                  hint: 'Enter card holder name',

                                  prefixIcon: const SizedBox(),
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Enter card holder name';
                                    }
                                    return null;
                                  },

                                  // onChanged: (value) {
                                  //   _formKey.currentState!.validate();
                                  // }
                                ),
                                PaymentComponents.creditCardNumberTFFWithTitle(
                                    controller: controller.cardNumber.value,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'Enter 16 digits card number';
                                      }
                                      return null;
                                    },
                                    title: 'Card number',
                                    hint: '5559 - 3131 - 4241 - 9955'),
                                Row(
                                  children: [
                                    Expanded(
                                        child: PaymentComponents
                                            .creditCardExpiryWithTitle(
                                                controller:
                                                    controller.expiryDate.value,
                                                validator: (value) {
                                                  if (value!.trim().isEmpty) {
                                                    return "Enter your card's expiry date";
                                                  }
                                                  return null;
                                                },
                                                title: 'Expiry (MM/YY)',
                                                hint: '12/30')),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                        child: PaymentComponents
                                            .creditCardCVVTFFWithTitle(
                                                controller: controller
                                                    .cardCodeCVV.value,
                                                validator: (value) {
                                                  if (value!.trim().isEmpty) {
                                                    return "Enter your card's code";
                                                  }
                                                  return null;
                                                },
                                                title: 'Card code',
                                                hint: '120')),
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Powered by',
                                      style:
                                          TextStylesCustom.textStyles_14.apply(
                                        color: ColorStyle.greyColor_0A09F99,
                                        fontWeightDelta: 3,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Image.asset(
                                      ImageStyle.vivaWallet,
                                      height: 26,
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: ElevatedButtonLoadingCustom(
                                    keyCustom: 'Submit Offset',
                                    text: 'Submit Offset',
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    colorBG: ColorStyle.primaryColor_52BC7F,
                                    style: TextStylesCustom.textStyles_16.apply(
                                        color: Colors.white,
                                        fontWeightDelta: 3),
                                    isLoading: controller.isLoading.value,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();

                                      if (_formKey.currentState!.validate()) {
                                        controller.submitOffSetButton(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
