import 'package:tuco2/Components/TermsOfUse_PrivacyPolicy.dart';
import 'package:tuco2/Controllers/ForgotPasswordEmailVerificationController.dart';

import '../Components/AlreadyHaveAnAccountLogin.dart';
import '../ExportFiles/ExportFilesAuth.dart';
import '../ExportFiles/ExportFilesMust.dart';

class ForgotPasswordEmailVerification extends StatelessWidget {
  ForgotPasswordEmailVerification(
      {Key? key, required this.emailFromForgotPassword})
      : super(key: key);

  final String emailFromForgotPassword;

  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(ForgotPasswordEmailVerificationController());

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
          init: ForgotPasswordEmailVerificationController(),
          initState: (_) {
            controller.emailFromForgotPassword = emailFromForgotPassword;
            controller.initCustom();
          },
          builder: (_) {
            return Obx(() => Column(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: SingleChildScrollView(
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
                                'Reset Password',
                                style: TextStyleAuth.textStylesHeader,
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 6,
                              ),
                              Text(
                                'Please enter your new password.',
                                style: TextStylesCustom.textStyles_14.apply(
                                    fontWeightDelta: 2,
                                    color: ColorStyle.greyColor_606060),
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 24,
                              ),
                              AuthScreenComponents
                                  .textFormFieldWithTitlePassword(
                                controller: controller.password,
                                title: 'Password',
                                isStar: false,
                                hint: 'Enter your password',
                                prefixIcon: Image.asset(ImageStyle.key),
                                validator: (value) =>
                                    ValidatorAuth.password(value!),
                                // onChanged: (value) {
                                //   _formKey.currentState!.validate();
                                // }
                              ),
                              AuthScreenComponents
                                  .textFormFieldWithTitlePassword(
                                controller: controller.confirm_password,
                                title: 'Confirm Password',
                                isStar: false,
                                hint: 'Enter confirm password',
                                prefixIcon: Image.asset(ImageStyle.key),
                                validator: (value) =>
                                    ValidatorAuth.password(value!),
                                // onChanged: (value) {
                                //   _formKey.currentState!.validate();
                                // }
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 40,
                              ),
                              ElevatedButtonLoadingCustom(
                                keyCustom: 'Reset Password',
                                text: 'Reset Password',
                                width: MediaQuery.of(context).size.width,
                                colorBG: ColorStyle.primaryColor_52BC7F,
                                style: TextStylesCustom.textStyles_16.apply(
                                    color: Colors.white, fontWeightDelta: 3),
                                // isLoading: false,
                                isLoading: controller.isLoading.value,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    controller.getNewPasswordButton();
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
                                  Get.close(3); // working ...

                                  // Navigator.of(Get.context!)
                                  //     .popUntil((route) => route.isFirst); // working ...

                                  // Get.until((route) => route.isFirst); // working ...

                                  // Navigator.of(Get.context!).popUntil(ModalRoute.withName('/ForgotPassword')); working ...
                                  // Get.until((route) => route.settings.name == '/ForgotPassword'); working ...
                                },
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    TermsOfUse_PrivacyPolicy(),
                  ],
                ));
          },
        ));
  }
}
