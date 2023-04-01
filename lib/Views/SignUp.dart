import 'package:tuco2/Components/TermsOfUse_PrivacyPolicy.dart';

import '../Components/AlreadyHaveAnAccountLogin.dart';
import '../Controllers/SignUpController.dart';
import '../ExportFiles/ExportFilesAuth.dart';
import '../ExportFiles/ExportFilesMust.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final controller = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
        body: GetBuilder(
          init: SignUpController(),
          builder: (auth) {
            return Obx(() => SingleChildScrollView(
                  padding: AuthScreenWidgetStyle.firstPaddingScreen(),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Form(
                          key: _formKey,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   controller.isAcceptTheTermsAndConditions.value.toString()
                              // ),
                              AuthScreenComponents.logoForAuthScreen(),
                              // const LogoForAuthScreen(),
                              const Divider(
                                color: Colors.transparent,
                                height: 40,
                              ),
                              Text(
                                'Create an account',
                                style: TextStyleAuth.textStylesHeader,
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 24,
                              ),
                              AuthScreenComponents.textFormFieldWithTitle(
                                title: 'First Name',
                                isStar: true,
                                hint: 'Enter your first name',
                                controller: controller.firstName,
                                prefixIcon: Image.asset(ImageStyle.user),
                                validator: (value) =>
                                    ValidatorAuth.firstName(value!),
                                // onChanged: (value) {
                                //   _formKey.currentState!.validate();
                                // }
                              ),
                              AuthScreenComponents.textFormFieldWithTitle(
                                title: 'Last Name',
                                isStar: true,
                                controller: controller.lastName,
                                hint: 'Enter your last name',
                                prefixIcon: Image.asset(ImageStyle.user),
                                validator: (value) =>
                                    ValidatorAuth.lastName(value!),
                              ),

                              AuthScreenComponents.textFormFieldWithTitle(
                                title: 'Email Address',
                                isStar: true,
                                hint: 'Enter your email address',
                                controller: controller.email,
                                prefixIcon: Image.asset(ImageStyle.mail),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidatorAuth.email(value!),
                                // onChanged: (value) {
                                //   _formKey.currentState!.validate();
                                // }
                              ),
                              AuthScreenComponents
                                  .textFormFieldWithTitlePassword(
                                title: 'Password',
                                isStar: true,
                                hint: 'Enter your password',
                                controller: controller.password,
                                prefixIcon: Image.asset(ImageStyle.key),
                                validator: (value) =>
                                    ValidatorAuth.password(value!),
                                // onChanged: (value) {
                                //   _formKey.currentState!.validate();
                                // }
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 25,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.isAcceptTheTermsAndConditions
                                                .value =
                                            !controller
                                                .isAcceptTheTermsAndConditions
                                                .value;
                                      },
                                      child: Icon(
                                        controller.isAcceptTheTermsAndConditions
                                                .value
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        size: 24,
                                        color: ColorStyle.primaryColor_52BC7F,
                                      )),
                                  const VerticalDivider(
                                    // color: Colors.transparent,
                                    width: 6,
                                  ),
                                  TextRichCustom(
                                    textFirst: 'I accept the ',
                                    textFirstStyle:
                                        TextStylesCustom.textStyles_13.apply(
                                            fontWeightDelta: 2,
                                            color: ColorStyle.greyColor_999999),
                                    textSecond: 'Terms & Conditions',
                                    textSecondStyle:
                                        TextStylesCustom.textStyles_13.apply(
                                            fontWeightDelta: 3,
                                            color:
                                                ColorStyle.primaryColor_52BC7F),
                                    onTap: () {
                                      debugPrint(
                                          'Terms & Conditions are tapping ...');
                                      'asdf'.showSuccess;
                                    },
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 25,
                              ),
                              ElevatedButtonLoadingCustom(
                                keyCustom: 'Signup',
                                text: 'Signup',
                                width: MediaQuery.of(context).size.width,
                                colorBG: ColorStyle.primaryColor_52BC7F,
                                style: TextStylesCustom.textStyles_16.apply(
                                    color: Colors.white, fontWeightDelta: 3),
                                // isLoading: false,
                                isLoading: controller.isLoading.value,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (controller
                                        .isAcceptTheTermsAndConditions.value) {
                                      controller.signUpButton();
                                    } else {
                                      'Please accept the terms & conditions.'
                                          .showError();
                                    }
                                  }
                                },
                              ),

                              // ElevatedButtonLoadingCustom(
                              //   text: 'Signup',
                              //   width: MediaQuery.of(context).size.width,
                              //   colorBG: ColorStyle.primaryColor_52BC7F,
                              //   style: TextStylesCustom.textStyles_16
                              //       .apply(color: Colors.white, fontWeightDelta: 3),
                              //   onTap: () {
                              //     if (_formKey.currentState!.validate()) {
                              //       if (!controller
                              //           .isAcceptTheTermsAndConditions.value) {
                              //         'Please accept the terms & conditions.'
                              //             .showError();
                              //       }
                              //       controller.signUpButton();
                              //     }
                              //   },
                              // ),

                              const Divider(
                                color: Colors.transparent,
                                height: 25,
                              ),

                              InkWell(
                                child: AlreadyHaveAnAccountLogin(),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Get.back();
                                },
                              ),

                              // Center(
                              //   child: TextRichCustom(
                              //     textFirst: 'Already have an account? ',
                              //     textFirstStyle: TextStylesCustom.textStyles_12.apply(
                              //         fontWeightDelta: 2,
                              //         color: ColorStyle.greyColor_999999
                              //     ),
                              //     textSecond: 'Login',
                              //     textSecondStyle: TextStylesCustom.textStyles_12.apply(
                              //         fontWeightDelta: 6,
                              //         color: ColorStyle.primaryColor_52BC7F
                              //     ),
                              //     onTap: () {
                              //       FocusScope.of(context).unfocus();
                              //
                              //       Get.back();
                              //     },
                              //   ),
                              // ),

                              const Divider(
                                color: Colors.transparent,
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TermsOfUse_PrivacyPolicy(),
                    ],
                  ),
                ));
          },
        ));
  }
}
