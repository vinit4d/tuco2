import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Styles/ColorStyle.dart';
import '../Styles/TextStyles.dart';

class TextRichCustom extends StatelessWidget {
  final String? textFirst;
  final String? textSecond;
  final Function()? onTap;
  final TextStyle? textFirstStyle;
  final textSecondStyle;

  const TextRichCustom(
      {Key? key,
      this.textFirst = 'Text First',
      this.textSecond = 'Text Second',
      this.onTap,
      this.textFirstStyle = const TextStyle(color: Colors.white),
      this.textSecondStyle = const TextStyle(color: Colors.grey)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   children: [
    //     Text(
    //       textFirst!,
    //       style: textFirstStyle,
    //     ),
    //     InkWell(
    //       onTap: onTap,
    //       // onTap: () {
    //       //   debugPrint('asdfasfadfadfsdaf');
    //       // },
    //       child: Text(
    //         textSecond!,
    //         style: textSecondStyle,
    //       ),
    //     ),
    //   ],
    // );
    return Text.rich(
      TextSpan(
        style: TextStylesCustom.textStyles_14.apply(),
        children: [
          TextSpan(
              text: textFirst,
              style: textFirstStyle
          ),
          TextSpan(
            text: textSecond,
            style: textSecondStyle,
            // recognizer: LongPressGestureRecognizer()..onLongPress = () {
            //   debugPrint('adsfafadfafafafdfadf');
            // },
            // recognizer: TapGestureRecognizer()..onTap = onTap,
            recognizer: TapGestureRecognizer()..onTap = () => debugPrint('Tap Here onTap'),
          ),
        ],
      ),
    );
  }
}
