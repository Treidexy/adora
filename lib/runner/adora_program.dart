import 'dart:math';
import 'dart:ui';

import 'package:adora/compiler/expr.dart';
import 'package:adora/compiler/parser.dart';
import 'package:adora/compiler/pretty_print.dart';
import 'package:adora/compiler/token.dart';
import 'package:adora/editor/line_editor.dart';
import 'package:adora/runner/adora_state.dart';
import 'package:adora/runner/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdoraProgram {
  final AdoraState state = AdoraState();
  final Function onChange;

  AdoraProgram({required this.onChange});

  Value _simpleFoldEval(Token op, List<NumberValue> list) {
    switch (op.kind) {
      case TokenKind.comma:
        return ListValue(list);

      case TokenKind.plus:
        return NumberValue(list.fold(0, (a, b) => a + b.value));
      case TokenKind.minus:
        return NumberValue(list.fold(0, (a, b) => a - b.value));
      case TokenKind.star:
        return NumberValue(list.fold(1, (a, b) => a * b.value));
      case TokenKind.slash:
        return NumberValue(
          list.sublist(1).fold(list.first.value, (a, b) => a / b.value),
        );
      case TokenKind.percent:
        return NumberValue(
          list.sublist(1).fold(list.first.value, (a, b) => a % b.value),
        );
      case TokenKind.caret:
        return NumberValue(
          list
              .sublist(1)
              .fold(list.first.value, (a, b) => pow(a, b.value) as double),
        );
      default:
        return NullValue();
    }
  }

  Value eval(Expr expr) {
    if (expr is NumberExpr) {
      return NumberValue(expr.value);
    }

    if (expr is FoldExpr) {
      final list = [for (final item in expr.list) eval(item)];
      bool ist = list.fold(true, (p, e) => p && e is NumberValue);
      if (ist) {
        final simple = [for (final item in list) item as NumberValue];
        return _simpleFoldEval(expr.op, simple);
      }
      return NullValue();
    }

    return NullValue();
  }

  void parse(List<LineData> lines) {
    state.points.clear();

    for (var line in lines) {
      var text = line.controller.text;

      final parser = Parser(text);
      final expr = parser.parse();
      print(prettyPrint(expr));
      final value = eval(expr);

      if (value is ListValue && value.list.length == 2) {
        final first = value.list[0];
        final second = value.list[1];

        if (first is NumberValue && second is NumberValue) {
          state.points.add((
            Offset(first.value, second.value),
            line.color,
            line.stroke,
          ));
        }
      }
    }

    onChange();
  }
}
