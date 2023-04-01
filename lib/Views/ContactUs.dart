import 'package:tuco2/Components/ContactUsController.dart';
import 'package:tuco2/Views/DrawerCustom.dart';

import '../Components/TransportationComponents.dart';
import '../ExportFiles/ExportFilesAuth.dart';
import '../ExportFiles/ExportFilesMust.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      body: GetBuilder(
        init: ContactUsController(),
        initState: (_) {
          Future.delayed(const Duration(milliseconds: 800), () {
            controller.initCustom();
          });
        },
        builder: (_) {
          return Obx(() => SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.transparent,
                        height: 20,
                      ),
                      Text(
                        'Contact Us',
                        style: TextStylesCustom.textStyles_24.apply(
                          color: ColorStyle.greyColor_606060,
                          fontWeightDelta: 3,
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            AuthScreenComponents.textFormFieldWithTitle(
                              controller: controller.name,
                              title: 'Enter Name',
                              isStar: true,
                              hint: 'Enter your first name',
                              prefixIcon: Image.asset(ImageStyle.user),
                              validator: (value) =>
                                  ValidatorAuth.firstName(value!),
                              // onChanged: (value) {
                              //   _formKey.currentState!.validate();
                              // }
                            ),
                            const Divider(
                              color: Colors.transparent,
                              height: 10,
                            ),
                            AuthScreenComponents.textFormFieldWithTitle(
                              controller: controller.email,
                              title: 'Email Address',
                              isStar: true,
                              hint: 'Enter your email address',
                              prefixIcon: Image.asset(ImageStyle.mail),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => ValidatorAuth.email(value!),
                              // onChanged: (value) {
                              //   _formKey.currentState!.validate();
                              // }
                            ),
                            const Divider(
                              color: Colors.transparent,
                              height: 10,
                            ),
                            TransportationComponents.textFormFieldContactUs(
                              controller: controller.description,
                              title: 'Description',
                              isStar: true,
                              hint: 'Write your message...',
                              minLines: 3,
                              maxLines: 10,
                              validator: (value) =>
                                  ValidatorAuth.messageDescription(value!),
                            ),
                            const Divider(
                              color: Colors.transparent,
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: ElevatedButtonLoadingCustom(
                                keyCustom: 'Send Message',
                                text: 'Send Message',
                                width: MediaQuery.of(context).size.width,
                                colorBG: ColorStyle.primaryColor_52BC7F,
                                style: TextStylesCustom.textStyles_14.apply(
                                    color: Colors.white, fontWeightDelta: 2),
                                isLoading: controller.isLoading.value,
                                onTap: () {
                                  FocusScope.of(context).unfocus();

                                  if (_formKey.currentState!.validate()) {
                                    debugPrint('Login is tapping ...');

                                    controller.sendMessageButton();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
