import 'package:tuco2/Components/TermsOfUse_PrivacyPolicy.dart';

import '../Controllers/LoginController.dart';
import '../ExportFiles/ExportFilesAuth.dart';
import '../ExportFiles/ExportFilesMust.dart';
import '../Styles/Strings.dart';
import '../Views/ForgotPassword.dart';
import '../Views/SignUp.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());

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
          init: LoginController(),
          initState: (_) {
            controller.reset();
          },
          builder: (auth) {
            return SingleChildScrollView(
              // padding: AuthScreenWidgetStyle.firstPaddingScreen(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SingleChildScrollView(
                      padding: AuthScreenWidgetStyle.firstPaddingScreen(),
                      child: AbsorbPointer(
                        absorbing: controller.isLoading.value,
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
                                Constants.welcomeBack,
                                style: TextStyleAuth.textStylesHeader,
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 6,
                              ),
                              Text(
                                Constants.are_you_ready_to_make_difference,
                                style: TextStylesCustom.textStyles_14.apply(
                                    fontWeightDelta: 3,
                                    color: ColorStyle.greyColor_606060),
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 24,
                              ),
                              AuthScreenComponents.textFormFieldWithTitle(
                                  title: Constants.email_address,
                                  isStar: false,
                                  hint: Constants.enter_your_email_address,
                                  prefixIcon: Image.asset(ImageStyle.mail),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controller.email,
                                  validator: (value) =>
                                      ValidatorAuth.email(value!),
                                  keyCustom: const Key('email')),
                              AuthScreenComponents
                                  .textFormFieldWithTitlePassword(
                                      title: 'Password',
                                      isStar: false,
                                      hint: Constants.enter_your_password,
                                      prefixIcon: Image.asset(ImageStyle.key),
                                      controller: controller.password,
                                      validator: (value) =>
                                          ValidatorAuth.password(value!),
                                      keyCustom: const Key('password')),
                              const Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    key: const Key('forgotPassword'),
                                    child: Text(
                                      Constants.forgot_password,
                                      style: TextStylesCustom.textStyles_12
                                          .apply(
                                              fontWeightDelta: 3,
                                              color:
                                                  ColorStyle.greyColor_999999),
                                    ),
                                    onTap: () {
                                      _formKey.currentState!.reset();
                                      Get.to(ForgotPassword());
                                    },
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          key: const Key('rememberMe'),
                                          onTap: () {
                                            controller.isRememberMe.value =
                                                !controller.isRememberMe.value;
                                            controller.update();
                                          },
                                          child: Icon(
                                            controller.isRememberMe.value
                                                ? Icons.check_box
                                                : Icons.check_box_outline_blank,
                                            size: 24,
                                            color:
                                                ColorStyle.primaryColor_52BC7F,
                                          )),
                                      const VerticalDivider(
                                        // color: Colors.transparent,
                                        width: 4,
                                      ),
                                      Text(
                                        Constants.remeber_me,
                                        style: TextStylesCustom.textStyles_12
                                            .apply(
                                                fontWeightDelta: 3,
                                                color: ColorStyle
                                                    .greyColor_999999),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 25,
                              ),
                              ElevatedButtonLoadingCustom(
                                keyCustom: 'Login',
                                text: 'Login',
                                width: MediaQuery.of(context).size.width,
                                colorBG: ColorStyle.primaryColor_52BC7F,
                                style: TextStylesCustom.textStyles_16.apply(
                                    color: Colors.white, fontWeightDelta: 3),
                                // isLoading: false,
                                isLoading: controller.isLoading.value,
                                onTap: () {
                                  FocusScope.of(context).unfocus();

                                  if (_formKey.currentState!.validate()) {
                                    debugPrint('Login is tapping ...');

                                    controller.loginButton();
                                  }
                                },
                              ),

                              const Divider(
                                color: Colors.transparent,
                                height: 25,
                              ),

                              InkWell(
                                key: const Key("don'tHaveAnAccount?Register"),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account ? ",
                                      style: TextStylesCustomPoppins
                                          .textStyles_13
                                          .apply(
                                              // fontWeightDelta: 2,
                                              color:
                                                  ColorStyle.greyColor_606060),
                                    ),
                                    Text(
                                      'Register',
                                      style: TextStylesCustomPoppins
                                          .textStyles_13
                                          .apply(
                                              fontWeightDelta: 3,
                                              color: ColorStyle
                                                  .primaryColor_52BC7F),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  FocusScope.of(context).unfocus();

                                  Get.to(const SignUp());
                                },
                              ),
                              // Center(
                              //   child: TextRichCustom(
                              //     textFirst: "Don't have an account? ",
                              //     textFirstStyle: TextStylesCustom.textStyles_12
                              //         .apply(
                              //             fontWeightDelta: 2,
                              //             color: ColorStyle.greyColor_999999),
                              //     textSecond: 'Register',
                              //     textSecondStyle: TextStylesCustom.textStyles_12
                              //         .apply(
                              //             fontWeightDelta: 5,
                              //             color: ColorStyle.primaryColor_52BC7F),
                              //     onTap: () {
                              //       FocusScope.of(context).unfocus();
                              //
                              //       Get.to(const SignUp());
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
                    ),
                  ),
                  TermsOfUse_PrivacyPolicy(),
                ],
              ),
            );
          },
        ));
  }
}
