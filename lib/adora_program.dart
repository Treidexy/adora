import 'dart:ui';

import 'package:adora/editor/line_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdoraProgram {
  final List<(Offset, Color, double)> points = [];
  final Function onChange;

  AdoraProgram({required this.onChange});

  void parse(List<LineData> lines) {
    points.clear();

    for (var line in lines) {
      var text = line.controller.text;
      text.trim();
      int open = text.indexOf('(');
      int comma = text.indexOf(',');
      int close = text.indexOf(')');

      if (open == -1 || comma == -1 || close == -1) {
        continue;
      }

      double x = double.parse(text.substring(open + 1, comma));
      double y = double.parse(text.substring(comma + 1, close));
      points.add((Offset(x, y), line.color, line.stroke));
    }

    onChange();
  }
}
