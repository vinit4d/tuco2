import 'dart:async';
import 'dart:io';

import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:notification_center/notification_center.dart';
import 'package:tuco2/Components/CreditCard/PaymentComponents.dart';
import 'package:tuco2/Views/ContactUs.dart';
import 'package:tuco2/Views/Donation/DonationProjectListingScreen.dart';

import '../Components/PickerCustom.dart';
import '../Controllers/ProfileController.dart';
import '../ExportFiles/ExportFilesAuth.dart';
import '../ExportFiles/ExportFilesMust.dart';
import 'BlogListing.dart';
import 'FrequentlyAskedQuestions.dart';
import 'StaticPage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = Get.put(ProfileController());
  final _paymentKey = GlobalKey<FormState>();
  final formEditProfile = GlobalKey<FormState>();
  final formChangePassword = GlobalKey<FormState>();

  onPressedPhotoPicker() {
    PickerCustom.imagePicker(
      (file) async {
        controller.image.value = file;
      },
    );
  }

  final FocusNode focusNodePhoneNumber = FocusNode();
Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationCenter().subscribe('navigateFromDrawer', navigateFromDrawer);
    // timer =
    //     Timer.periodic(Duration(seconds: 15), (Timer t) => checkIsUserLogin());
  }

  checkIsUserLogin() {
    controller.getProfile();
  }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }
  void navigateFromDrawer(String pageName) {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (pageName.toLowerCase().contains('contact')) {
        navigateMultiBottom(context, ContactUs());
      } else if (pageName
          .toLowerCase()
          .contains('supportedProjects'.toLowerCase())) {
        navigateMultiBottom(context, DonationProjectListingScreen(isFromSupportedProjectsScreen: true,));
      } else if (pageName.toLowerCase().contains('tips')) {
        navigateMultiBottom(context, BlogListing());
      } else if (pageName.toLowerCase().contains('faqs')) {
        navigateMultiBottom(context, FrequentlyAskedQuestions());
      } else if (pageName.toLowerCase().contains('privacy')) {
        navigateMultiBottom(
            context,
            StaticPage(
              pageName: 'Privacy policy',
            ));
      } else if (pageName.toLowerCase().contains('terms')) {
        navigateMultiBottom(
            context,
            StaticPage(
              pageName: 'Terms and conditions',
            ));
      } else if (pageName.toLowerCase().contains('about')) {
        navigateMultiBottom(
            context,
            StaticPage(
              pageName: 'About Us',
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        initState: (_) {
          controller.initStateCustom();
        },
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Obx(() => GestureDetector(
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
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 25,
                        bottom: 25,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: onPressedPhotoPicker,
                                child: Center(
                                  child: Stack(children: [
                                    if (controller.image.value.path.isEmpty)
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(136),
                                            // color: Colors.grey.withOpacity(0.5),
                                            border: Border.all(
                                              color: ColorStyle
                                                  .primaryColor_52BC7F,
                                              width: 3,
                                            )),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(68),
                                          child: Image.network(
                                              controller.profilePicture.value,
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, url, error) =>
                                                      Image.network(
                                                        'https://media.glamourmagazine.co.uk/photos/62ea5ac396a3ad6877093558/1:1/w_1920,h_1920,c_limit/AMBER%20HEARD%20TIDE%20TURN%20030822%20default-sq-GettyImages-1154257098.jpg',
                                                        height: 90,
                                                        width: 90,
                                                      )),

                                          // CachedNetworkImage(
                                          //   height: 110,
                                          //   width: 110,
                                          //   fit: BoxFit.cover,
                                          //   imageUrl: controller
                                          //       .profilePicture.value,
                                          //   progressIndicatorBuilder:
                                          //       (context, url,
                                          //               downloadProgress) =>
                                          //           CircularProgressIndicator(
                                          //     value:
                                          //         downloadProgress.progress,
                                          //     color:
                                          //         ColorStyle.hex('#FF3984'),
                                          //   ),
                                          //   errorWidget:
                                          //       (context, url, error) =>
                                          //           Container(
                                          //     height: 136,
                                          //     width: 136,
                                          //     margin:
                                          //         const EdgeInsets.all(10),
                                          //     child: Icon(
                                          //       Icons.person,
                                          //       size: 54,
                                          //       color: ColorStyle
                                          //           .primaryColor_52BC7F,
                                          //     ),
                                          //   ),
                                          // )
                                        ),
                                      )
                                    else
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(136),
                                            border: Border.all(
                                              color: ColorStyle
                                                  .primaryColor_52BC7F,
                                              width: 3,
                                            )),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              ColorStyle.primaryColor_52BC7F,
                                          radius: 68,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(68),
                                              child: Image.file(
                                                File(controller
                                                    .image.value.path),
                                                fit: BoxFit.fill,
                                                height: 136,
                                                width: 136,
                                              )),
                                        ),
                                      ),
                                    Positioned(
                                        bottom: 0,
                                        right: -20,
                                        child: RawMaterialButton(
                                          onPressed: onPressedPhotoPicker,
                                          // controller.getImage(),
                                          elevation: 2,
                                          fillColor: Colors.white,
                                          padding: const EdgeInsets.all(8.0),
                                          shape: const CircleBorder(),
                                          child: Image.asset(
                                            ImageStyle.editProfile,
                                            width: 16,
                                          ),
                                        )),
                                  ]),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${controller.firstName.text} ${controller.lastName.text}',
                            textAlign: TextAlign.center,
                            style: TextStylesCustom.textStyles_22.apply(
                              color: ColorStyle.greyColor_606060,
                              fontWeightDelta: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              // alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: ColorStyle.greyColor_0E6E6E6,
                                      width: 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Edit Profile',
                                        // textAlign: TextAlign.left,
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                      Icon(
                                        controller.arrSelected[0]
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  if (controller.arrSelected[0])
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Form(
                                        key: formEditProfile,
                                        child: Column(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 20,
                                            ),
                                            AuthScreenComponents
                                                .textFormFieldWithTitle(
                                              title: 'First Name',
                                              isStar: true,
                                              hint: 'Enter your first name',
                                              controller: controller.firstName,

                                              prefixIcon:
                                                  Image.asset(ImageStyle.user),
                                              validator: (value) =>
                                                  ValidatorAuth.firstName(
                                                      value!),
                                              // onChanged: (value) {
                                              //   _formKey.currentState!.validate();
                                              // }
                                            ),
                                            AuthScreenComponents
                                                .textFormFieldWithTitle(
                                              title: 'Last Name',
                                              isStar: true,
                                              controller: controller.lastName,
                                              hint: 'Enter your last name',
                                              prefixIcon:
                                                  Image.asset(ImageStyle.user),
                                              validator: (value) =>
                                                  ValidatorAuth.lastName(
                                                      value!),
                                            ),
                                            AuthScreenComponents
                                                .textFormFieldWithTitle(
                                              title: 'Email Address',
                                              isStar: true,
                                              hint: 'Enter your email address',
                                              controller: controller.email,
                                              prefixIcon:
                                                  Image.asset(ImageStyle.mail),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (value) =>
                                                  ValidatorAuth.email(value!),
                                              // onChanged: (value) {
                                              //   _formKey.currentState!.validate();
                                              // }
                                            ),
                                            AuthScreenComponents
                                                .textFormFieldWithPhone(
                                              controller: controller.phone,
                                              title: 'Phone Number',
                                              hint: '0987654321',
                                              isStar: false,
                                              focusNode: focusNodePhoneNumber,
                                              // validator: (value) =>
                                              //     ValidatorAuth.phoneNumber(
                                              //         value!),
                                            ),
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 25,
                                            ),
                                            ElevatedButtonLoadingCustom(
                                              keyCustom: 'Save',
                                              text: 'Save',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              colorBG: ColorStyle
                                                  .primaryColor_52BC7F,
                                              style: TextStylesCustom
                                                  .textStyles_16
                                                  .apply(
                                                      color: Colors.white,
                                                      fontWeightDelta: 3),
                                              // isLoading: false,
                                              isLoading: controller
                                                  .isLoadingProfile.value,
                                              onTap: () {
                                                if (formEditProfile
                                                    .currentState!
                                                    .validate()) {
                                                  controller
                                                      .updateProfileButton();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            onTap: () {
                              FocusScope.of(context).unfocus();

                              controller.setProfileData();

                              for (int i = 0;
                                  i < controller.arrSelected.length;
                                  i++) {
                                if (i == 0) {
                                  controller.arrSelected[i] = true;
                                } else {
                                  controller.arrSelected[i] = false;
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              // alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: ColorStyle.greyColor_0E6E6E6,
                                      width: 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Change Password',
                                        // textAlign: TextAlign.left,
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                      Icon(
                                        controller.arrSelected[1]
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  if (controller.arrSelected[1])
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Form(
                                        key: formChangePassword,
                                        child: Column(
                                          children: [
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 20,
                                            ),
                                            AuthScreenComponents
                                                .textFormFieldWithTitlePassword(
                                              title: 'Password',
                                              isStar: true,
                                              hint: 'Enter your password',
                                              controller:
                                                  controller.passwordOld.value,
                                              prefixIcon:
                                                  Image.asset(ImageStyle.key),
                                              validator: (value) =>
                                                  ValidatorAuth.password(
                                                      value!),
                                              // onChanged: (value) {
                                              //   _formKey.currentState!.validate();
                                              // }
                                            ),
                                            AuthScreenComponents
                                                .textFormFieldWithTitlePassword(
                                              title: 'New Password',
                                              isStar: true,
                                              hint: 'Enter New password',
                                              controller:
                                                  controller.passwordNew.value,
                                              prefixIcon:
                                                  Image.asset(ImageStyle.key),
                                              validator: (value) =>
                                                  ValidatorAuth.password(
                                                      value!),
                                              // onChanged: (value) {
                                              //   _formKey.currentState!.validate();
                                              // }
                                            ),
                                            AuthScreenComponents
                                                .textFormFieldWithTitlePassword(
                                              title: 'Confirm New password',
                                              isStar: true,
                                              hint: 'Confirm New password',
                                              controller: controller
                                                  .passwordConfirm.value,
                                              prefixIcon:
                                                  Image.asset(ImageStyle.key),
                                              validator: (value) =>
                                                  ValidatorAuth.password(
                                                      value!),
                                              // onChanged: (value) {
                                              //   _formKey.currentState!.validate();
                                              // }
                                            ),
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 25,
                                            ),
                                            ElevatedButtonLoadingCustom(
                                              keyCustom: 'Change Password',
                                              text: 'Change Password',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              colorBG: ColorStyle
                                                  .primaryColor_52BC7F,
                                              style: TextStylesCustom
                                                  .textStyles_16
                                                  .apply(
                                                color: Colors.white,
                                                fontWeightDelta: 3,
                                              ),
                                              // isLoading: false,
                                              isLoading: controller
                                                  .isLoadingChangePassword
                                                  .value,
                                              onTap: () async {
                                                if (formChangePassword
                                                    .currentState!
                                                    .validate()) {
                                                  final result = await controller
                                                      .saveChangePasswordButton(
                                                          context);

                                                  if (result == true) {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      formChangePassword
                                                          .currentState!
                                                          .reset();
                                                    });
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            onTap: () {
                              FocusScope.of(context).unfocus();

                              for (int i = 0;
                                  i < controller.arrSelected.length;
                                  i++) {
                                if (i == 1) {
                                  controller.arrSelected[i] = true;
                                } else {
                                  controller.arrSelected[i] = false;
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              // alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: ColorStyle.greyColor_0E6E6E6,
                                      width: 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Payment Method',
                                        // textAlign: TextAlign.left,
                                        style: TextStylesCustom.textStyles_16
                                            .apply(
                                          color: ColorStyle.greyColor_606060,
                                          fontWeightDelta: 3,
                                        ),
                                      ),
                                      Icon(
                                        controller.arrSelected[2]
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  if (controller.arrSelected[2])
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Form(
                                        key: _paymentKey,
                                        child: Column(
                                          children: [
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 20,
                                            ),
                                            AuthScreenComponents
                                                .textFormFieldWithTitle(
                                                    controller: controller
                                                        .cardHolderName.value,
                                                    title: 'Card holder name',
                                                    isStar: true,
                                                    hint:
                                                        'Enter card holder name',
                                                    prefixIcon:
                                                        const SizedBox(),
                                                    validator: (value) {
                                                      if (value!.isEmpty)
                                                        return 'Please Enter Card Holder Name';

                                                      return null;
                                                    }),
                                            PaymentComponents
                                                .creditCardNumberTFFWithTitle(
                                                    controller: controller
                                                        .cardNumber.value,
                                                    validator: (value) {
                                                      debugPrint(
                                                          "value  ${value!.trim().length}");
                                                      if (value!.isEmpty)
                                                        return 'Please Enter Card Number';
                                                      else if (value
                                                              .trim()
                                                              .length <
                                                          16)
                                                        return 'Please Enter Correct Card Number';

                                                      return null;
                                                    },
                                                    title: 'Card number',
                                                    hint:
                                                        '5559 - 3131 - 4241 - 9955'),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: PaymentComponents
                                                        .creditCardExpiryWithTitle(
                                                            controller:
                                                                controller
                                                                    .expiryDate
                                                                    .value,
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty)
                                                                return 'Please Enter Expiry Date';

                                                              return null;
                                                            },
                                                            title:
                                                                'Expiry (MM/YY)',
                                                            hint: '12/30')),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                    child: PaymentComponents
                                                        .creditCardCVVTFFWithTitle(
                                                            controller:
                                                                controller
                                                                    .cardCode
                                                                    .value,
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty)
                                                                return 'Please Enter Card Code';

                                                              return null;
                                                            },
                                                            title: 'Card code',
                                                            hint: '120')),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 25,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Powered by',
                                                  style: TextStylesCustom
                                                      .textStyles_14
                                                      .apply(
                                                    color: ColorStyle
                                                        .greyColor_0A09F99,
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
                                            ElevatedButtonLoadingCustom(
                                              keyCustom: 'Save',
                                              text: 'Save',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              colorBG: ColorStyle
                                                  .primaryColor_52BC7F,
                                              style: TextStylesCustom
                                                  .textStyles_16
                                                  .apply(
                                                      color: Colors.white,
                                                      fontWeightDelta: 3),
                                              isLoading: controller
                                                  .isLoadingPaymentMethod.value,
                                              onTap: () {
                                                if (_paymentKey.currentState!
                                                    .validate()) {
                                                  controller
                                                      .savePaymentMethodButton(
                                                          context);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            onTap: () {
                              FocusScope.of(context).unfocus();

                              controller.setPaymentMethodData();

                              for (int i = 0;
                                  i < controller.arrSelected.length;
                                  i++) {
                                if (i == 2) {
                                  controller.arrSelected[i] = true;
                                } else {
                                  controller.arrSelected[i] = false;
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }
}
