import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';

import '../Styles/ColorStyle.dart';
import '../Styles/TextStyles.dart';

class PickerCustom {
  static datePicker(String dateFormat) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2500));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      final dateStringJiffy =
          Jiffy.parseFromDateTime(picked).format(pattern: dateFormat);

      return dateStringJiffy;
    }
  }

  static imagePicker(Function(File) onSelected) {
    Get.bottomSheet(InkWell(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  'From Camera',
                  style: TextStylesCustom.textStyles_16
                      .apply(color: Colors.black, fontWeightDelta: 2),
                ),
                onTap: () async {
                  Get.back();

                  final ImagePicker _picker = ImagePicker();
                  final imageFile = await _picker.pickImage(
                      source: ImageSource.camera,
                      // maxHeight:  200 ,
                      maxWidth: 500);

                  onSelected(File(imageFile!.path));
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(
                  'From Photo',
                  style: TextStylesCustom.textStyles_16
                      .apply(color: Colors.black, fontWeightDelta: 2),
                ),
                onTap: () async {
                  Get.back();

                  final ImagePicker _picker = ImagePicker();
                  final imageFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                      // maxHeight:  200 ,
                      maxWidth: 500);

                  onSelected(File(imageFile!.path));

                  // Image.file(File(imageFile.path));
                  // File(imageFile.path);
                },
              ),
              Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  height: 1,
                  color: ColorStyle.primaryColor_52BC7F),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorStyle.primaryColor_52BC7F,
                      borderRadius: BorderRadius.circular(25)),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: TextStylesCustom.textStyles_16
                        .apply(color: Colors.white, fontWeightDelta: 2),
                  ),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Get.back();
      },
    ));
  }
}
