import '../ExportFiles/ExportFilesMust.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Notification',
            style: TextStylesCustom.textStyles_26
                .apply(color: ColorStyle.greyColor_606060, fontWeightDelta: 3)),
      ),
    );
  }
}
