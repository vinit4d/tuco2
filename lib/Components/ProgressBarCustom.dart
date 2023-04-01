import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Styles/ColorStyle.dart';
import '../Styles/TextStyles.dart';

class ProgressBarCustom extends StatelessWidget {
  double paid;
  double totalPayment;

  ProgressBarCustom({Key? key, required this.paid, required this.totalPayment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 60,
      animation: true,
      animationDuration: 1000,
      padding: const EdgeInsets.all(0),
      percent: (paid / totalPayment > 1.0) ? 1.0 : paid / totalPayment,
      center: Text("\$ ${paid} of \$ ${totalPayment}",
        style: TextStylesCustom.textStyles_16.apply(
            color: Colors.white
        ),
      ),
      progressColor:
          (paid / totalPayment > 1.0) ? Colors.red : Colors.grey,
      barRadius: const Radius.circular(10),
    );
  }
}

class ProgressBarCircularCustom extends StatelessWidget {
  String text;
  double progress;
  double total;

  ProgressBarCircularCustom({Key? key, required this.text, required this.progress, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 30,
      lineWidth: 7.0,
      animation: true,
      animationDuration: 1000,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.grey,
      progressColor: Colors.red,
      percent: (progress / total > 1.0) ? 1.0 : progress / total,
      center: Text(
          text,
          style: TextStylesCustom.textStyles_13.apply(
              fontWeightDelta: 2,
              color: ColorStyle.primaryColor_52BC7F
          )
      ),
    );
  }
}
