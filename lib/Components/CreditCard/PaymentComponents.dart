import '../../Components/TextFormFieldCustom.dart';
import '../../ExportFiles/ExportFilesMust.dart';
class PaymentComponents {
  static creditCardNumberTFFWithTitle({
    required String title,
    required String hint,
    bool isStar = true,
    TextInputType keyboardType = TextInputType.number,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Key? keyCustom,
  }) {
    return Column(
      children: [
        const Divider(
          color: Colors.transparent,
          height: 16,
        ),
        Row(
          children: [
            Text(
              title,
              style: TextStyleAuth.textStylesTextFieldTitle,
            ),
            if (isStar)
              Text(
                '*',
                style: TextStyleAuth.textStylesTextFieldTitle
                    .apply(color: ColorStyle.redColor_0F15222),
              ),
          ],
        ),
        const Divider(
          color: Colors.transparent,
          height: 8,
        ),
        TextFormFieldCardNumber(
         
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          keyboardType: keyboardType,
          keyCustom: keyCustom,
          padding: const EdgeInsets.only(
            // left: 10,
            // right: 10,
            top: 16,
            bottom: 16,
          ),
          textStyle: TextStylesCustom.textStyles_15
              .apply(fontWeightDelta: 3, color: ColorStyle.greyColor_606060),
          // textStyle: TextStyleAuth.textStylesTextFieldText.apply(
          //   color: ColorStyle.greyColor_606060,
          //   fontWeightDelta: 3,
          // ),
        ),
      ],
    );
  }

  static creditCardExpiryWithTitle({
    required String title,
    required String hint,
    bool isStar = true,
    TextInputType keyboardType = TextInputType.number,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Key? keyCustom,
  }) {
    return Column(
      children: [
        const Divider(
          color: Colors.transparent,
          height: 16,
        ),
        Row(
          children: [
            Text(
              title,
              style: TextStyleAuth.textStylesTextFieldTitle,
            ),
            if (isStar)
              Text(
                '*',
                style: TextStyleAuth.textStylesTextFieldTitle
                    .apply(color: ColorStyle.redColor_0F15222),
              ),
          ],
        ),
        const Divider(
          color: Colors.transparent,
          height: 8,
        ),
        TextFormFieldExpiryDate(
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          keyboardType: keyboardType,
          keyCustom: keyCustom,
          padding: const EdgeInsets.only(
            // left: 10,
            // right: 10,
            top: 16,
            bottom: 16,
          ),
          textStyle: TextStylesCustom.textStyles_15
              .apply(fontWeightDelta: 3, color: ColorStyle.greyColor_606060),
        ),
      ],
    );
  }

  static creditCardCVVTFFWithTitle({
    required String title,
    required String hint,
    bool isStar = true,
    TextInputType keyboardType = TextInputType.number,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Key? keyCustom,
  }) {
    return Column(
      children: [
        const Divider(
          color: Colors.transparent,
          height: 16,
        ),
        Row(
          children: [
            Text(
              title,
              style: TextStyleAuth.textStylesTextFieldTitle,
            ),
            if (isStar)
              Text(
                '*',
                style: TextStyleAuth.textStylesTextFieldTitle
                    .apply(color: ColorStyle.redColor_0F15222),
              ),
          ],
        ),
        const Divider(
          color: Colors.transparent,
          height: 8,
        ),
        TextFormFieldCVV(
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          keyboardType: keyboardType,
          keyCustom: keyCustom,
          padding: const EdgeInsets.only(
            // left: 10,
            // right: 10,
            top: 16,
            bottom: 16,
          ),
          textStyle: TextStylesCustom.textStyles_15
              .apply(fontWeightDelta: 3, color: ColorStyle.greyColor_606060),
          // textStyle: TextStyleAuth.textStylesTextFieldText.apply(
          //   color: ColorStyle.greyColor_606060,
          //   fontWeightDelta: 3,
          // ),
        ),
      ],
    );
  }
}
