import 'package:flutter/material.dart';

import '../Styles/ColorStyle.dart';
import '../Styles/TextStyles.dart';

class DropdownButtonCustom extends StatefulWidget {
  final Function(String)? onChanged;

  final double? width;
  final double? height;
  final List? list;
  final EdgeInsets? padding;
  final Color? colorIcon;
  final IconData? icon;
  final TextStyle? textStyle;
  final TextStyle? titleStyle;
  final String? hintText;
  final String? title;

  final Color? bgColor;

  DropdownButtonCustom(
      {Key? key,
      this.onChanged,
      this.width = 150,
      this.height = 50,
      this.list = const ['One', 'Two', 'Three'],
      this.padding = const EdgeInsets.all(0),
      this.colorIcon = Colors.red,
      this.textStyle = const TextStyle(color: Colors.red),
      this.hintText = 'Type your hint text here',
      this.icon = Icons.add,
      this.titleStyle = const TextStyle(color: Colors.green),
      this.bgColor = Colors.pink,
      this.title = 'Title'})
      : super(key: key);

  @override
  State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon(
          //   widget.icon,
          //   color: ColorStyle.black_000000,
          //   size: 26,
          // ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title.toString(),
                  style: widget.titleStyle!.apply(color: Colors.pink),
                ),
                Expanded(
                    child: DropdownButton<String>(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Icon(
                      Icons.expand_more,
                      size: 25,
                      color: widget.colorIcon,
                    ),
                  ),
                  // iconSize: 0,
                  value: dropdownValue,
                  isExpanded: true,
                  elevation: 16,
                  style: widget.textStyle,
                  hint: Text(
                    widget.hintText!,
                    style: widget.textStyle!,
                    textAlign: TextAlign.center,
                  ),
                  underline: Container(
                    height: 0,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (value) {
                    dropdownValue = value;
                    setState(() {});
                  },
                  items: widget.list!
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: widget.textStyle!,
                            ),
                          ))
                      .toList(),
                )),
              ],
            ),
          ),
          // Icon(
          //   Icons.expand_more,
          //   size: 25,
          //   color: widget.colorIcon,
          // ),
        ],
      ),
    );
  }
}

class DropdownWithLabel extends StatelessWidget {
  const DropdownWithLabel({
    Key? key,
    this.firstText = 'hint text',
    this.secondText = '*',
    // this.hintText = 'hintText',
    this.ontap,
    this.width = 150,
    this.height = 50,
    this.list,
    this.dropdownValue = '',
  }) : super(key: key);

  final String? firstText;
  final String? secondText;

  // final String? hintText;
  final Function()? ontap;

  // final Color? colorBG;
  final double? width;
  final double? height;
  final List? list;
  final String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              firstText!,
              style: TextStylesCustom.textStyles_14,
            ),
            Text(
              secondText!,
              style: TextStylesCustom.textStyles_14
                  .apply(color: ColorStyle.primaryColor_52BC7F),
            ),
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        SizedBox(
          width: width,
          height: height,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                //border of dropdown button
                borderRadius: BorderRadius.circular(5)),
            child: DropdownButton<String>(
              value: list!.first,
              isExpanded: true,
              icon: Icon(
                Icons.expand_more,
                size: 35,
                color: ColorStyle.primaryColor_52BC7F,
              ),
              elevation: 16,
              style: TextStyle(color: Colors.grey),
              underline: Container(
                height: 0,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                // setState(() {
                //   dropdownValue = value!;
                // });
              },
              items: list!
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}

class PopupMenuCustom extends StatefulWidget {
  const PopupMenuCustom({
    Key? key,
    required this.onChanged,
    this.padding = EdgeInsets.zero,
    this.list = const ['One', 'Two', 'Three'],
    this.selectedText = 'All',
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
    this.width = 200,
  }) : super(key: key);

  final List? list;
  final EdgeInsets padding;
  final Function(int)? onChanged;
  final String? selectedText;
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
  final double? width;

  @override
  State<PopupMenuCustom> createState() => _PopupMenuCustomState();
}

class _PopupMenuCustomState extends State<PopupMenuCustom> {
  String selectedValue = 'All';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 50),
      padding: widget.padding,
      constraints: BoxConstraints(maxHeight: widget.width!),
      itemBuilder: (context) {
        return List.generate(widget.list!.length, (index) {
          return PopupMenuItem(
            onTap: () {
              selectedValue = widget.list![index];
              widget.onChanged!(index);

              setState(() {});
            },
            child: Text(
              widget.list![index],
              style: widget.textStyle,
              maxLines: 1,
            ),
          );
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.title!,
                  style: widget.textStyleTitle,
                ),
                if (widget.isStar!)
                  TextSpan(
                    text: '*',
                    style: TextStylesCustom.textStyles_15.apply(
                      color: ColorStyle.redColor_0F15222,
                      fontWeightDelta: 2,
                    ),
                  ),
              ],
            ),
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Container(
          //       constraints: BoxConstraints(maxWidth: widget.width! - 10),
          //       child: Text(
          //         widget.title!,
          //         textAlign: TextAlign.left,
          //         style: widget.textStyleTitle,
          //       ),
          //     ),
          //     if (widget.isStar!)
          //       Text(
          //         '*',
          //         textAlign: TextAlign.left,
          //         style: TextStylesCustom.textStyles_15.apply(
          //           color: ColorStyle.redColor_0F15222,
          //           fontWeightDelta: 2,
          //         ),
          //       )
          //   ],
          // ),
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
            style: widget.textStyle!.apply(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.black,
                  size: 26,
                )),
            enabled: false,
            // onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
