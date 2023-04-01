import 'package:flutter/material.dart';
import '../Styles/ColorStyle.dart';


class SwitchCustom extends StatelessWidget {
  bool isSwitched;
  Function(bool) onChanged;

  SwitchCustom({Key? key, this.isSwitched = false, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      // onChanged: widget.onChanged,
      onChanged: (value) {
        onChanged(value);
      },
      activeTrackColor: Colors.red.withOpacity(.3),
      activeColor: Colors.red,
    );
  }
}




