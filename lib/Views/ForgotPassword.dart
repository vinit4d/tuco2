import 'package:tuco2/Components/TermsOfUse_PrivacyPolicy.dart';
import 'package:tuco2/Views/OTPScreen.dart';

import '../Components/AlreadyHaveAnAccountLogin.dart';
import '../Controllers/ForgotPasswordController.dart';
import '../ExportFiles/ExportFilesAuth.dart';
import '../ExportFiles/ExportFilesMust.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final controller = Get.put(ForgotPasswordController());

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
          init: ForgotPasswordController(),
          initState: (_) {
            controller.initCustom();
          },
          builder: (_) {
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AuthScreenComponents.logoForAuthScreen(),
                              const Divider(
                                color: Colors.transparent,
                                height: 40,
                              ),
                              Text(
                                'Forgot Password?',
                                style: TextStyleAuth.textStylesHeader,
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 6,
                              ),
                              Text(
                                'Please enter your Email Address. You will receive an email message with instructions on how to reset your password.',
                                style: TextStylesCustom.textStyles_14.apply(
                                    fontWeightDelta: 2,
                                    color: ColorStyle.greyColor_606060),
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 24,
                              ),
                              AuthScreenComponents.textFormFieldWithTitle(
                                title: 'Email Address',
                                isStar: false,
                                hint: 'Enter your email address',
                                prefixIcon: Image.asset(ImageStyle.mail),
                                controller: controller.controllerEmail,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidatorAuth.email(value!),
                                // onChanged: (value) {
                                //   _formKey.currentState!.validate();
                                // }
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 40,
                              ),
                              ElevatedButtonLoadingCustom(
                                keyCustom: 'Get New Password',
                                text: 'Get New Password',
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
                                   
                                    controller.forgotPasswordButton();
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

                                  Get.back();
                                },
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
