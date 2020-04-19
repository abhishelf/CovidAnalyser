import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;

class BarItem {
  final String type;
  final int count;
  final charts.Color color;

  BarItem(this.type, this.count, Color color) : this.color = new charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);
}