
import 'package:flutter/material.dart';

BoxDecoration boxDecorationAuthBox() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          // blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ]
  );
}