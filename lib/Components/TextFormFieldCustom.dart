import 'dart:developer';

import 'package:country_calling_code_picker/picker.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tuco2/Components/CreditCard/input_formatters.dart';

import '../ExportFiles/ExportFilesMust.dart';

class TextFormFieldAuth extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Widget prefixIcon;
  final Key? keyCustom;

  const TextFormFieldAuth({
    Key? key,
    this.controller,
    this.validator,
    // this.onChanged,
    this.padding = EdgeInsets.zero,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.prefixIcon = const Icon(
      Icons.search,
      color: Colors.red,
    ),
    this.keyCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      key: keyCustom,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: 1,
      style: textStyle!,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: colorFill,
        errorMaxLines: 2,
        // contentPadding: padding,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: prefixIcon,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 50,
          maxHeight: 50,
        ),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        hintText: hintText,
        hintStyle: textStyle!.apply(color: colorHint),
        errorStyle: textStyle!
            .apply(fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
        contentPadding: padding,
      ),
      // onChanged: onChanged,
    );
  }
}

class TextFormFieldPhoneAuth extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  Function(String)? onSelected;

  // final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Key? keyCustom;
  final FocusNode? focusNode;

  // final Widget prefixIcon;
  // final String? labelText;

  TextFormFieldPhoneAuth({
    Key? key,
    this.controller,
    this.validator,
    // this.onChanged,
    this.padding = EdgeInsets.zero,
    this.hintText,
    this.focusNode,
    // this.keyboardType = TextInputType.text,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.onSelected,
    this.keyCustom,
  }) : super(key: key);

  @override
  State<TextFormFieldPhoneAuth> createState() => _TextFormFieldPhoneAuthState();
}

class _TextFormFieldPhoneAuthState extends State<TextFormFieldPhoneAuth> {
  String countryCode = '+1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCurrentLocale();

    // debugPrint('keyboard keyboard keyboard keyboard ${_keyboardIsVisible()}');
  }

  _getCurrentLocale() async {
    countryCode = await CountryCodeCurrentCustom.getCurrentLocale();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      key: widget.keyCustom,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.number,
      // keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: 1,
      style: widget.textStyle!,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        fillColor: widget.colorFill,
        errorMaxLines: 2,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        hintText: widget.hintText,
        hintStyle: widget.textStyle!.apply(color: widget.colorHint),
        errorStyle: widget.textStyle!
            .apply(fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
        contentPadding: widget.padding,
        prefixIconConstraints: const BoxConstraints(
            // maxWidth: 62,
            // maxHeight: 50,
            // minWidth: 50
            ),
        prefixIcon: InkWell(
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            margin: const EdgeInsets.only(
              right: 10,
            ),
            decoration: BoxDecoration(
                // color: ColorStyle.greyColor_0A09F99,
                // borderRadius: BorderRadius.circular(10),
                border: Border(
                    right: BorderSide(
              color: ColorStyle.greyColor_0A09F99,
              width: 1.5,
            ))),
            child: Text(
              countryCode,
              style: TextStyleAuth.textStylesTextFieldText
                  .apply(color: Colors.black),
            ),
          ),
          onTap: () async {
            FocusScope.of(context).unfocus();

            await showModalBottomSheet<Country?>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) {
                  return Container(
                    // height: 600,
                    height: MediaQuery.of(context).size.height / 2 + 100,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                'Choose country',
                                textAlign: TextAlign.center,
                                style: widget.textStyle!.apply(
                                    color: Colors.black, fontSizeDelta: 2),
                              ),
                              TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: widget.textStyle!.apply(
                                      color: ColorStyle.redColor_0F15222,
                                    ),
                                  ),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: CountryPickerWidget(
                            searchInputDecoration: InputDecoration(
                              isDense: true,
                              hintText: 'Search ...',
                              hintStyle: widget.textStyle!
                                  .apply(color: ColorStyle.greyColor_606060),
                              helperStyle:
                                  widget.textStyle!.apply(color: Colors.black),
                              counterStyle:
                                  widget.textStyle!.apply(color: Colors.black),
                              floatingLabelStyle:
                                  widget.textStyle!.apply(color: Colors.black),
                              labelStyle:
                                  widget.textStyle!.apply(color: Colors.black),
                              errorStyle:
                                  widget.textStyle!.apply(color: Colors.black),
                              prefixStyle:
                                  widget.textStyle!.apply(color: Colors.black),
                              suffixStyle:
                                  widget.textStyle!.apply(color: Colors.black),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 30,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                            flagIconSize: 24,
                            itemTextStyle:
                                widget.textStyle!.apply(color: Colors.black),
                            onSelected: (country) {
                              countryCode = country.callingCode;
                              widget.onSelected!(countryCode);

                              Navigator.pop(context);

                              // Get.back();

                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
      // onChanged: widget.onChanged,
    );
  }
}

class CountryCodeCurrentCustom {
  static Future<String> getCurrentLocale() async {
    try {
      await CountryCodes.init();

      final CountryDetails details = CountryCodes.detailsForLocale();
      // final countryCode = details.dialCode.toString().replaceAll('+', '');
      final countryCode = details.dialCode.toString();
      log(countryCode);
      return countryCode;
    } catch (error) {
      log("Error obtaining current locale");
      log(error.toString());

      return error.toString();
    }
  }
}

class TextFormFieldPasswordAuth extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Widget prefixIcon;
  final Key? keyCustom;

  const TextFormFieldPasswordAuth({
    Key? key,
    this.controller,
    this.validator,
    // this.onChanged,
    this.padding = EdgeInsets.zero,
    this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.prefixIcon = const Icon(
      Icons.search,
      color: Colors.red,
    ),
    this.keyCustom,
  }) : super(key: key);

  @override
  State<TextFormFieldPasswordAuth> createState() =>
      _TextFormFieldPasswordAuthState();
}

class _TextFormFieldPasswordAuthState extends State<TextFormFieldPasswordAuth> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      key: widget.keyCustom,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: 1,
      style: widget.textStyle!,
      obscureText: isObscureText,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          errorMaxLines: 6,
          fillColor: widget.colorFill,
          // contentPadding: padding,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxWidth: 50,
            maxHeight: 50,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radiusBorder!),
              borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radiusBorder!),
              borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radiusBorder!),
              borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radiusBorder!),
              borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radiusBorder!),
              borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
          hintText: widget.hintText,
          hintStyle: widget.textStyle!.apply(color: widget.colorHint),
          errorStyle: widget.textStyle!
              .apply(fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
          contentPadding: widget.padding,
          suffixIcon: IconButton(
            icon: Icon(
              isObscureText ? Icons.visibility_off : Icons.visibility,
              color: ColorStyle.greyColor_0A09F99,
            ),
            onPressed: () {
              isObscureText = !isObscureText;
              setState(() {});
            },
          )),
      // onChanged: widget.onChanged,
    );
  }
}

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final int? minLines;
  final Key? keyCustom;
  final FocusNode? focusNode;

  const TextFormFieldCustom(
      {Key? key,
      this.controller,
      this.validator,
      // this.onChanged,
      this.padding = EdgeInsets.zero,
      this.hintText,
      this.keyboardType = TextInputType.text,
      this.colorFill = Colors.white,
      this.colorBorder = Colors.black,
      this.colorHint = Colors.grey,
      this.colorText = Colors.black,
      this.textStyle = const TextStyle(),
      this.radiusBorder = 8.0,
      this.minLines = 1,
      this.maxLines = 1,
      this.keyCustom,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      key: keyCustom,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      style: textStyle!,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: colorFill,
        errorMaxLines: 2,
        isDense: true,
        // contentPadding: padding,
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.only(
        //     left: 10,
        //     right: 10,
        //   ),
        //   // child: prefixIcon,
        // ),
        // prefixIconConstraints: const BoxConstraints(
        //   maxWidth: 50,
        //   maxHeight: 50,
        // ),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder!),
            borderSide: BorderSide(color: colorBorder!, width: 1)),
        hintText: hintText,
        hintStyle: textStyle!.apply(color: colorHint),
        errorStyle: textStyle!
            .apply(fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
        contentPadding: padding,
      ),
      // onChanged: onChanged,
    );
  }
}

class TextFormFieldDatePicker extends StatefulWidget {
  const TextFormFieldDatePicker({
    Key? key,
    required this.onTap,
    this.padding = EdgeInsets.zero,
    // this.list = const ['One', 'Two', 'Three'],
    // this.selectedText = 'All',
    this.isStar = false,
    required this.title,
    this.textStyleTitle = const TextStyle(fontSize: 16, color: Colors.red),
    this.controller,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.red),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.keyCustom,
  }) : super(key: key);

  // final List? list;
  final EdgeInsets padding;
  final Function()? onTap;

  // final String? selectedText;
  final String? title;
  final TextStyle? textStyleTitle;
  final bool? isStar;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Key? keyCustom;

  @override
  State<TextFormFieldDatePicker> createState() =>
      _TextFormFieldDatePickerState();
}

class _TextFormFieldDatePickerState extends State<TextFormFieldDatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title!,
                textAlign: TextAlign.left,
                style: widget.textStyleTitle,
              ),
              if (widget.isStar!)
                Text(
                  '*',
                  textAlign: TextAlign.left,
                  style: TextStylesCustom.textStyles_15.apply(
                    color: ColorStyle.redColor_0F15222,
                    fontWeightDelta: 2,
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            key: widget.keyCustom,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            minLines: 1,
            style: widget.textStyle!.apply(
                // color: Colors.black.
                ),
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                fillColor: widget.colorFill,
                errorMaxLines: 2,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                hintText: widget.hintText,
                hintStyle: widget.textStyle!.apply(color: widget.colorHint),
                errorStyle: widget.textStyle!.apply(
                    fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
                contentPadding: widget.padding,
                prefixIcon: Container(
                  margin: const EdgeInsets.only(right: 6, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: ColorStyle.greyColor_0E6E6E6,
                              width: 1.5))),
                  child: Icon(
                    Icons.calendar_month,
                    color: ColorStyle.primaryColor_52BC7F,
                    size: 26,
                  ),
                )
                // prefixIcon: Icon(
                //   Icons.calendar_month,
                //   color: ColorStyle.primaryColor_52BC7F,
                //   size: 26,
                // )
                ),
            enabled: false,
            // onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class TextFormFieldLocation extends StatefulWidget {
  const TextFormFieldLocation({
    Key? key,
    required this.onTap,
    this.padding = EdgeInsets.zero,
    // this.list = const ['One', 'Two', 'Three'],
    // this.selectedText = 'All',
    this.isStar = false,
    required this.title,
    this.textStyleTitle = const TextStyle(fontSize: 16, color: Colors.red),
    this.controller,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.red),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.keyCustom,
    this.focusNode,
  }) : super(key: key);

  // final List? list;
  final EdgeInsets padding;
  final Function()? onTap;

  // final String? selectedText;
  final String? title;
  final TextStyle? textStyleTitle;
  final bool? isStar;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Key? keyCustom;
  final FocusNode? focusNode;

  @override
  State<TextFormFieldLocation> createState() => _TextFormFieldLocationState();
}

class _TextFormFieldLocationState extends State<TextFormFieldLocation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title!,
              textAlign: TextAlign.left,
              style: widget.textStyleTitle,
            ),
            if (widget.isStar!)
              Text(
                '*',
                textAlign: TextAlign.left,
                style: TextStylesCustom.textStyles_15.apply(
                  color: ColorStyle.redColor_0F15222,
                  fontWeightDelta: 2,
                ),
              )
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          validator: widget.validator,
          key: widget.keyCustom,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          minLines: 1,
          style: widget.textStyle!.apply(),
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              fillColor: widget.colorFill,
              errorMaxLines: 2,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder!),
                  borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder!),
                  borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder!),
                  borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder!),
                  borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder!),
                  borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
              hintText: widget.hintText,
              hintStyle: widget.textStyle!.apply(color: widget.colorHint),
              errorStyle: widget.textStyle!.apply(
                  fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
              contentPadding: widget.padding,
              prefixIconConstraints: BoxConstraints(maxWidth: 66),
              prefixIcon: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      ImageStyle.location,
                      height: 32,
                      width: 32,
                    ),
                    Container(
                      width: 2.6,
                      height: 30,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        // top: 6,
                        // bottom: 6,
                      ),
                      decoration: BoxDecoration(
                          color: ColorStyle.greyColor_0E6E6E6,
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ),
              )),
          // enabled: false,
          // onChanged: onChanged,
        ),
      ],
    );
  }
}

class TextFormFieldLocationGooglePlaces extends StatefulWidget {
  const TextFormFieldLocationGooglePlaces({
    Key? key,
    required this.onTap,
    this.padding = EdgeInsets.zero,
    // this.list = const ['One', 'Two', 'Three'],
    // this.selectedText = 'All',
    this.isStar = false,
    required this.title,
    this.textStyleTitle = const TextStyle(fontSize: 16, color: Colors.red),
    this.controller,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.red),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.keyCustom,
    this.focusNode,
  }) : super(key: key);

  // final List? list;
  final EdgeInsets padding;
  final Function(String)? onTap;

  // final String? selectedText;
  final String? title;
  final TextStyle? textStyleTitle;
  final bool? isStar;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Key? keyCustom;
  final FocusNode? focusNode;

  @override
  State<TextFormFieldLocationGooglePlaces> createState() =>
      _TextFormFieldLocationGooglePlacesState();
}

class _TextFormFieldLocationGooglePlacesState
    extends State<TextFormFieldLocationGooglePlaces> {
  String googleApikey = "AIzaSyANDsDeGl7DmtDWAsdi98MxwP0kVxDzbPI";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  // String location = "Search Location";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.title!.isNotEmpty)
          Row(
            children: [
              Text(
                widget.title!,
                textAlign: TextAlign.left,
                style: widget.textStyleTitle,
              ),
              if (widget.isStar!)
                Text(
                  '*',
                  textAlign: TextAlign.left,
                  style: TextStylesCustom.textStyles_15.apply(
                    color: ColorStyle.redColor_0F15222,
                    fontWeightDelta: 2,
                  ),
                )
            ],
          ),
        if (widget.title!.isNotEmpty)
          const SizedBox(
            height: 6,
          ),
        InkWell(
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            validator: widget.validator,
            key: widget.keyCustom,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            minLines: 1,
            enabled: false,
            style: widget.textStyle!.apply(),
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                fillColor: widget.colorFill,
                errorMaxLines: 2,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radiusBorder!),
                    borderSide:
                        BorderSide(color: widget.colorBorder!, width: 1)),
                hintText: widget.hintText,
                hintStyle: widget.textStyle!.apply(color: widget.colorHint),
                errorStyle: widget.textStyle!.apply(
                    fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
                contentPadding: widget.padding,
                prefixIconConstraints: BoxConstraints(maxWidth: 66),
                prefixIcon: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        ImageStyle.location,
                        height: 32,
                        width: 32,
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          // top: 6,
                          // bottom: 6,
                        ),
                        decoration: BoxDecoration(
                            color: ColorStyle.greyColor_0E6E6E6,
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ],
                  ),
                )),
            // enabled: false,
            // onChanged: onChanged,
          ),
          onTap: () async {
            var place = await PlacesAutocomplete.show(
                context: context,
                apiKey: googleApikey,
                mode: Mode.overlay,
                types: [],
                strictbounds: false,
                // components: [Component(Component.country, 'np')],
                //google_map_webservice package
                onError: (err) {
                  print(err);
                });
            if (place != null) {
              //form google_maps_webservice package
              final plist = GoogleMapsPlaces(
                apiKey: googleApikey,
                apiHeaders: await GoogleApiHeaders().getHeaders(),
                //from google_api_headers package
              );
              String placeid = place.placeId ?? "0";
              final detail = await plist.getDetailsByPlaceId(placeid);
              final geometry = detail.result.geometry!;
              // final lat = geometry.location.lat;
              // final lang = geometry.location.lng;
              // var newlatlang = LatLng(lat, lang);

              // print(detail.result.addressComponents);

              // print(detail.result.addressComponents.first.longName);
              // print(
              //     detail.result.addressComponents.last.shortName.toLowerCase());

              final firstName =
                  detail.result.addressComponents.first.longName.toLowerCase();
              final lastName =
                  detail.result.addressComponents.last.shortName.toLowerCase();

              // for (int i = 0; i < detail.result.addressComponents.length; i++) {
              //   print(detail.result.addressComponents.first.longName);
              //   print(detail.result.addressComponents.last.longName);
              //   print(detail.result.addressComponents[i].longName);
              //   print(detail.result.addressComponents[i].shortName);
              //   // print(detail.result.addressComponents[i].types);
              //   // print(detail.result.addressComponents[i].toJson());
              // }
              //
              // print(detail.result.url);

              widget.controller!.text = '${firstName}, ${lastName}';

              widget.onTap!(widget.controller!.text);

              setState(() {});
            }
          },
        ),
      ],
    );
  }
}

class TextFormFieldCardNumber extends StatefulWidget {
  const TextFormFieldCardNumber({
    Key? key,
    this.controller,
    this.validator,
    this.padding = EdgeInsets.zero,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.keyCustom,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Key? keyCustom;

  @override
  State<TextFormFieldCardNumber> createState() =>
      _TextFormFieldCardNumberState();
}

class _TextFormFieldCardNumberState extends State<TextFormFieldCardNumber> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      key: widget.keyCustom,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: 1,
      style: widget.textStyle!,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
      
        FilteringTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(16),
        new CardNumberInputFormatter()
      ],
      decoration: InputDecoration(
        fillColor: widget.colorFill,
        errorMaxLines: 2,
        // contentPadding: padding,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 50,
          maxHeight: 50,
        ),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        hintText: widget.hintText,
        hintStyle: widget.textStyle!.apply(color: widget.colorHint),
        errorStyle: widget.textStyle!
            .apply(fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
        contentPadding: widget.padding,
      ),
      // onChanged: onChanged,
    );
  }
}

class TextFormFieldExpiryDate extends StatefulWidget {
  const TextFormFieldExpiryDate({
    Key? key,
    this.controller,
    this.validator,
    this.padding = EdgeInsets.zero,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.keyCustom,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Key? keyCustom;

  @override
  State<TextFormFieldExpiryDate> createState() =>
      _TextFormFieldExpiryDateState();
}

class _TextFormFieldExpiryDateState extends State<TextFormFieldExpiryDate> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      key: widget.keyCustom,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: 1,
      style: widget.textStyle!,

      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(4),
        new CardMonthInputFormatter()
      ],

      decoration: InputDecoration(
        fillColor: widget.colorFill,
        errorMaxLines: 2,
        // contentPadding: padding,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 50,
          maxHeight: 50,
        ),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        hintText: widget.hintText,
        hintStyle: widget.textStyle!.apply(color: widget.colorHint),
        errorStyle: widget.textStyle!
            .apply(fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
        contentPadding: widget.padding,
      ),
      // onChanged: onChanged,
    );
  }
}

class TextFormFieldCVV extends StatefulWidget {
  const TextFormFieldCVV({
    Key? key,
    this.controller,
    this.validator,
    this.padding = EdgeInsets.zero,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.keyCustom,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Key? keyCustom;

  @override
  State<TextFormFieldCVV> createState() => _TextFormFieldCVVState();
}

class _TextFormFieldCVVState extends State<TextFormFieldCVV> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      key: widget.keyCustom,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: 1,
      style: widget.textStyle!,

      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(4),
      ],

      decoration: InputDecoration(
        fillColor: widget.colorFill,
        errorMaxLines: 2,
        // contentPadding: padding,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 50,
          maxHeight: 50,
        ),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder!),
            borderSide: BorderSide(color: widget.colorBorder!, width: 1)),
        hintText: widget.hintText,
        hintStyle: widget.textStyle!.apply(color: widget.colorHint),
        errorStyle: widget.textStyle!
            .apply(fontSizeFactor: 0.7, color: ColorStyle.redColor_0F15222),
        contentPadding: widget.padding,
      ),
      // onChanged: onChanged,
    );
  }
}
