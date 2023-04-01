import 'dart:async';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../Components/AlreadyHaveAnAccountLogin.dart';
import '../Components/TermsOfUse_PrivacyPolicy.dart';
import '../Controllers/OTPController.dart';
import '../ExportFiles/ExportFilesAuth.dart';
import '../ExportFiles/ExportFilesMust.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.emailFromForgotPassword})
      : super(key: key);

  final String emailFromForgotPassword;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode focusNodePhoneNumber = FocusNode();

  final controller = Get.put(OTPController());

  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timerResendOTP();
  }

  void timerResendOTP() {
    const oneSec = Duration(seconds: 1); //5min -> 5*60 = 300
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (controller.countDownForResendOTP.value == 0) {
          _timer?.cancel();
        } else {
          controller.timerResendOTP();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: OTPController(),
        initState: (_) {
          controller.emailFromForgotPassword = widget.emailFromForgotPassword;
          controller.initCustom();
        },
        builder: (_) {
          return Obx(() => Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      // child: KeyboardActions(
                      //   config: KeyboardActionsConfig(
                      //       keyboardActionsPlatform:
                      //           KeyboardActionsPlatform.ALL,
                      //       keyboardBarColor: Colors.grey[200],
                           
                            // actions: [
                            //   KeyboardActionsItem(
                            //       focusNode: focusNodePhoneNumber,
                            //       displayArrows: false,
                            //       toolbarButtons: [
                            //         (node) {
                            //           return GestureDetector(
                            //             onTap: () => node.unfocus(),
                            //             child: Padding(
                            //               padding:
                            //                   const EdgeInsets.only(right: 10),
                            //               child: Text(
                            //                 'Done',
                            //                 style: TextStylesCustom
                            //                     .textStyles_16
                            //                     .apply(
                            //                         color: Colors.black,
                            //                         fontWeightDelta: 3),
                            //               ),
                            //             ),
                            //           );
                            //         }
                            //       ]),
                            // ]),
                        
                          child: Padding(
                          padding: AuthScreenWidgetStyle.firstPaddingScreen(),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AuthScreenComponents.logoForAuthScreen(),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 40,
                                ),
                                Text(
                                  'OTP Verification',
                                  style: TextStyleAuth.textStylesHeader,
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 6,
                                ),
                                Text(
                                  'We have sent an OTP to your entered email address.',
                                  style: TextStylesCustom.textStyles_14.apply(
                                      fontWeightDelta: 2,
                                      color: ColorStyle.greyColor_606060),
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 24,
                                ),
                                OtpTextField(
                                  numberOfFields: 6,
                                  borderWidth: 4,
                                  autoFocus: true,
                                  borderColor: Colors.red,
                                  focusedBorderColor:
                                      ColorStyle.primaryColor_52BC7F,
                                  styles: [
                                    TextStylesCustom.textStyles_26.apply(
                                        fontWeightDelta: 2,
                                        color: ColorStyle.greyColor_606060),
                                    TextStylesCustom.textStyles_26.apply(
                                        fontWeightDelta: 2,
                                        color: ColorStyle.greyColor_606060),
                                    TextStylesCustom.textStyles_26.apply(
                                        fontWeightDelta: 2,
                                        color: ColorStyle.greyColor_606060),
                                    TextStylesCustom.textStyles_26.apply(
                                        fontWeightDelta: 2,
                                        color: ColorStyle.greyColor_606060),
                                    TextStylesCustom.textStyles_26.apply(
                                        fontWeightDelta: 2,
                                        color: ColorStyle.greyColor_606060),
                                    TextStylesCustom.textStyles_26.apply(
                                        fontWeightDelta: 2,
                                        color: ColorStyle.greyColor_606060),
                                  ],
                                  onCodeChanged: (String code) {
                                    debugPrint(code.length.toString());

                                    // controller.isSubmitOTP.value = false;

                                    // controller.isSubmitOTP.value =
                                    //     (code.length == 6) ? true : false;
                                  },
                                  onSubmit: (String verificationCode) {
                                    debugPrint(verificationCode);

                                    // controller.isSubmitOTP.value = true;
                                    controller.textOTP = verificationCode;
                                  },
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 26,
                                ),
                                InkWell(
                                  onTap:
                                      (controller.countDownForResendOTP.value ==
                                              0)
                                          ? () {
                                              controller.countDownForResendOTP
                                                  .value = 15;
                                              timerResendOTP();
                                            }
                                          : null,
                                  child: Text(
                                    (controller.countDownForResendOTP.value ==
                                            0)
                                        ? "Resend"
                                        : controller.countDownForResendOTP.value
                                            .toString(),
                                    style: TextStylesCustom.textStyles_16.apply(
                                        fontWeightDelta: 3,
                                        color: ColorStyle.greyColor_606060),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 20,
                                ),
                                // if (controller.isSubmitOTP.value)
                                ElevatedButtonLoadingCustom(
                                  keyCustom: 'Get New Password',
                                  text: 'Submit OTP',
                                  width: MediaQuery.of(context).size.width,
                                  colorBG: ColorStyle.primaryColor_52BC7F,
                                  style: TextStylesCustom.textStyles_16.apply(
                                      color: Colors.white, fontWeightDelta: 3),
                                  // isLoading: false,
                                  isLoading: controller.isLoading.value,
                                  onTap: () {
                                    FocusScope.of(context).unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      debugPrint(
                                          'Forgot password is tapping ...');

                                      controller.submitOTPButton();
                                    }
                                  },
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 40,
                                ),
                                InkWell(
                                  child: AlreadyHaveAnAccountLogin(),
                                  onTap: () {
                                    FocusScope.of(context).unfocus();

                                    Get.close(2); // working ...
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      // ),
                    ),
                    TermsOfUse_PrivacyPolicy(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
