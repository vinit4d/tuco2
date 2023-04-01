import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

class AlreadyHaveAnAccountLogin extends StatelessWidget {
  const AlreadyHaveAnAccountLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStylesCustomPoppins.textStyles_13.apply(
              // fontWeightDelta: 0,
              color: ColorStyle.greyColor_606060),
        ),
        Text(
          'Login',
          style: TextStylesCustomPoppins.textStyles_14
              .apply(fontWeightDelta: 3, color: ColorStyle.primaryColor_52BC7F),
        ),
      ],
    );
  }
}
