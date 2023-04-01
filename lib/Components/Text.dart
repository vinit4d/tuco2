import 'package:flutter/material.dart';

import '../Styles/ColorStyle.dart';
import '../Styles/TextStyles.dart';

Widget HeadingText(String title) {
  return Text(title,
      textAlign: TextAlign.start,
      style: TextStylesCustom.textStyles_22.apply(
        color: ColorStyle.greyColor_606060,
        fontWeightDelta: 3,
      ));
}

Widget BoldText(String text, Color color ) {
  return Text(text,
      textAlign: TextAlign.center,
      style: TextStylesCustom.textStylesBold_14.apply(
        color: color,
        fontWeightDelta: 3,
      ));
}
Widget BoldTextSize16(String text, Color color ) {
  return Text(text,
      textAlign: TextAlign.center,
      style: TextStylesCustom.textStylesBold_16.apply(
        color: color,
        fontWeightDelta: 3,
      ));
}

Widget normalText(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStylesCustom.textStyles_12
        .apply(color: ColorStyle.greyColor_606060, fontSizeDelta: 2),
  );
}

Widget normalTextFontsize10(String text) {
  return Flexible(
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStylesCustom.textStyles_10_
          .apply(color: ColorStyle.greyColor_606060, fontSizeDelta: 2),
    ),
  );
}


Widget boldText12(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStylesCustom.textStylesBold_12
        .apply(color: ColorStyle.greyColor_606060, fontSizeDelta: 2),
  );
}

Widget richText12(String heading, String title, Color color) {
  return Row(
    children: [
      Text(
        heading,
        textAlign: TextAlign.center,
        style: TextStylesCustom.textStylesBold_12
            .apply(color: ColorStyle.greyColor_606060, fontSizeDelta: 2),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStylesCustom.textStylesBold_12
            .apply(color: color, fontSizeDelta: 2),
      ),
    ],
  );
}

Widget headingGreenText(String title) {
  return Text(title,
      textAlign: TextAlign.start,
      style: TextStylesCustom.textStylesBold_24.apply(
        color: ColorStyle.greenColor_52BC7F,
        fontWeightDelta: 3,
      ));
}
