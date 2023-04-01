import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

class TermsOfUse_PrivacyPolicy extends StatefulWidget {
  const TermsOfUse_PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<TermsOfUse_PrivacyPolicy> createState() =>
      _TermsOfUse_PrivacyPolicyState();
}

class _TermsOfUse_PrivacyPolicyState extends State<TermsOfUse_PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Text(
                  'Terms of use',
                  style: TextStylesCustom.textStyles_14.apply(
                    fontWeightDelta: 2,
                    color: ColorStyle.greyColor_606060,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {},
              ),
              Text(
                ' & ',
                style: TextStylesCustom.textStyles_14.apply(
                  fontWeightDelta: 2,
                  color: ColorStyle.greyColor_606060,
                ),
              ),
              InkWell(
                child: Text(
                  'privacy policy',
                  style: TextStylesCustom.textStyles_14.apply(
                    fontWeightDelta: 2,
                    color: ColorStyle.greyColor_606060,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.transparent,
          height: 20,
        ),
      ],
    );
  }
}
