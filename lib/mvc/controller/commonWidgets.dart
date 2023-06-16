import 'dart:convert';

import 'package:flutter/material.dart';

class CommonWidget {
  static Widget getImage({required String base64String}) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
      width: 80,
      height: 80,
    );
  }
}
