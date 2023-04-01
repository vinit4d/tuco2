import '../ExportFiles/ExportFilesMust.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Calculator',
            style: TextStylesCustom.textStyles_26
                .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3)),
      ),
    );
  }
}
