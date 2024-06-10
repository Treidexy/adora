import 'dart:ui';

import 'package:adora/runner/scope.dart';
import 'package:adora/runner/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdoraState {
  final Scope mainScope = Scope(null);
  final List<(Offset, Color, double)> points = [];
  final List<Value> lines = [];
}
