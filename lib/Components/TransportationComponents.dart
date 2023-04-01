import '../../Components/TextFormFieldCustom.dart';
import '../../ExportFiles/ExportFilesMust.dart';

class TransportationComponents {
  static textFormFieldWithTitle({
    required String title,
    required String hint,
    bool isStar = true,
    TextInputType keyboardType = TextInputType.name,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Key? keyCustom,
    int? maxLines = 1,
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
              style: TextStylesCustom.textStyles_16.apply(
                color: ColorStyle.greyColor_606060,
                fontWeightDelta: 3,
              ),
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
        TextFormFieldCustom(
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          keyboardType: keyboardType,
          keyCustom: keyCustom,
          maxLines: maxLines,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 16,
            bottom: 16,
          ),
          textStyle: TextStylesCustom.textStyles_16
              .apply(fontWeightDelta: 3, color: ColorStyle.greyColor_606060),
        ),
      ],
    );
  }

  static textFormFieldContactUs({
    required String title,
    required String hint,
    bool isStar = true,
    TextInputType keyboardType = TextInputType.name,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Key? keyCustom,
    int? minLines = 1,
    int? maxLines = 1,
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
              style: TextStylesCustom.textStyles_16.apply(
                color: ColorStyle.greyColor_606060,
                fontWeightDelta: 3,
              ),
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
        TextFormFieldCustom(
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          keyboardType: keyboardType,
          keyCustom: keyCustom,
          minLines: minLines,
          maxLines: maxLines,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 16,
            bottom: 16,
          ),
          textStyle: TextStyleAuth.textStylesTextFieldText
              .apply(color: ColorStyle.greyColor_606060),
        ),
      ],
    );
  }
}
