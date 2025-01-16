import 'package:flutter/material.dart';

class Helper {
  static Color parseStringToColor(String colorString) {
    // Split the string and parse values
    List<String> values = colorString.split(',').map((v) => v.trim()).toList();
    int red = int.parse(values[0]);
    int green = int.parse(values[1]);
    int blue = int.parse(values[2]);
    double opacity = double.parse(values[3]);

    // Create and return the color
    return Color.fromRGBO(red, green, blue, opacity);
  }
}
