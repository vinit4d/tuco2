import 'dart:developer';

import 'package:get_storage/get_storage.dart';

import '../../Components/TextFormFieldCustom.dart';
import '../../ExportFiles/ExportFilesMust.dart';

class AuthScreenComponents {
  static logoForAuthScreen() {
    return Column(
      children: [
        const Divider(
          color: Colors.transparent,
          height: 60,
        ),
        Image.asset(
          ImageStyle.logoWithNamePNG,
          width: 190,
        ),
      ],
    );
  }

  static textFormFieldWithTitle({
    required String title,
    required Widget prefixIcon,
    required String hint,
    bool isStar = true,
    TextInputType keyboardType = TextInputType.name,
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
        TextFormFieldAuth(
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          prefixIcon: prefixIcon,
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

  static textFormFieldWithPhone({
    required String title,
    required String hint,
    bool isStar = true,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Key? keyCustom,
    FocusNode? focusNode,
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
        TextFormFieldPhoneAuth(
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          keyCustom: keyCustom,
          focusNode: focusNode,
          padding: const EdgeInsets.only(
            // left: 10,
            // right: 10,
            top: 16,
            bottom: 16,
          ),
          textStyle: TextStylesCustom.textStyles_15
              .apply(fontWeightDelta: 3, color: ColorStyle.greyColor_606060),
          onSelected: (value) {
            log('value value value value value value value');
            log(value);
          },
        ),
      ],
    );
  }

  // aashish.n1@addwebsolution.com
  // Addweb@123

  static textFormFieldWithTitlePassword({
    required String title,
    required Widget prefixIcon,
    required String hint,
    bool isStar = true,
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
        TextFormFieldPasswordAuth(
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          prefixIcon: prefixIcon,
          padding: const EdgeInsets.only(
            // left: 10,
            // right: 10,
            top: 16,
            bottom: 16,
          ),
          textStyle: TextStyleAuth.textStylesTextFieldText
              .apply(color: ColorStyle.greyColor_606060),
        ),
      ],
    );
  }

  static textFormFieldWithTitleWithoutPrefix({
    required String title,
    required Widget prefixIcon,
    required String hint,
    bool isStar = true,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Key? keyCustom,
    FocusNode? focusNode,
    TextInputType keyboardType = TextInputType.name,
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
        TextFormFieldCustom(
          focusNode: focusNode,
          controller: controller,
          validator: validator,
          hintText: hint,
          colorBorder: ColorStyle.greyColor_0E6E6E6,
          colorHint: ColorStyle.greyColor_0A09F99,
          radiusBorder: 6,
          keyboardType: keyboardType,
          padding: const EdgeInsets.only(
            left: 10,
            // right: 10,
            top: 16,
            bottom: 16,
          ),
          textStyle:
              TextStyleAuth.textStylesTextFieldText.apply(color: Colors.black),
        ),
      ],
    );
  }
}

userSaved(Map<String, dynamic> user) {
  final getStorage = GetStorage();
  getStorage.write('user', jsonEncode(user));
}
