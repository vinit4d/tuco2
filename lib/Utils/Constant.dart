import 'dart:io';

import 'package:get/get.dart';

Map<String, dynamic> dictData = {};
RxString avatar = ''.obs;

final String googleAPIKey = 'AIzaSyANDsDeGl7DmtDWAsdi98MxwP0kVxDzbPI';
final String androidGoogleAPIKey = 'AIzaSyDAaXdEz5Yvcvm121yEURBk9wTRh5nGj4M';
final String iOSGoogleAPIKey = 'AIzaSyAdQpqyL8B5N2EzvDDjBvPp0yc3CQleyMo';
final apiKey = Platform.isAndroid ? androidGoogleAPIKey : iOSGoogleAPIKey;

String tripID = '';

// https://maps.googleapis.com/maps/api/place/autocomplete/json?input=amoeba&key=AIzaSyDAaXdEz5Yvcvm121yEURBk9wTRh5nGj4M
