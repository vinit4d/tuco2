import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tuco2/ExportFiles/ExportFilesMust.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final Color? colorBG;
  final Color? colorText;
  final Color? colorIcon;
  final double? width;
  final double? height;
  final double borderRadius;
  final TextStyle style;
  final Key? keyCustom;

  const ElevatedButtonCustom({
    Key? key,
    this.onTap,
    this.text = "Elevated Button",
    this.colorBG = Colors.blue,
    this.colorText = Colors.white,
    this.colorIcon = Colors.black,
    this.width = 50,
    this.height = 50,
    this.style = const TextStyle(color: Colors.white),
    this.borderRadius = 8,
    this.keyCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: keyCustom,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorBG,
        elevation: 0,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        fixedSize: Size(width!, height!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text!,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}

class ElevatedButtonLoadingCustom extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final Color? colorBG;
  final Color? colorText;
  final Color? colorIcon;
  final double? width;
  final double? height;
  final double borderRadius;
  final TextStyle style;
  final bool isLoading;
  final String? keyCustom;

  const ElevatedButtonLoadingCustom({
    Key? key,
    this.onTap,
    this.text = "Elevated Button",
    this.colorBG = Colors.blue,
    this.colorText = Colors.white,
    this.colorIcon = Colors.black,
    this.width = 50,
    this.height = 50,
    this.style = const TextStyle(color: Colors.white),
    this.borderRadius = 8,
    this.isLoading = false,
    this.keyCustom,
  }) : super(key: key);

  @override
  State<ElevatedButtonLoadingCustom> createState() =>
      _ElevatedButtonLoadingCustomState();
}

class _ElevatedButtonLoadingCustomState
    extends State<ElevatedButtonLoadingCustom> {
  @override
  Widget build(BuildContext context) {
    final keyLoginLoader = '${widget.keyCustom!}Loader';

    return widget.isLoading
        ? Center(
            key: Key(keyLoginLoader),
            child: SpinKitCircle(
              // key: Key(keyLoginLoader),
              color: widget.colorBG,
              size: 50.0,
            )
            //   child: CircularProgressIndicator(
            //   color: widget.colorBG,
            //   strokeWidth: 4,
            //   backgroundColor: ColorStyle.greyColor_0A09F99,
            // ),
            )
        : ElevatedButton(
            key: Key(widget.keyCustom!),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.colorBG,
              elevation: 0,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              fixedSize: Size(widget.width!, widget.height!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
            onPressed: widget.onTap,
            child: Text(
              widget.text!,
              textAlign: TextAlign.center,
              style: widget.style,
            ),
          );
  }
}
