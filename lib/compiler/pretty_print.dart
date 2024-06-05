import 'package:adora/compiler/expr.dart';

String prettyPrint(Expr expr, [String indent = '', bool isLast = true]) {
  String out = '';
  // out = indent + (isLast ? '╰─' : '├─');
  String newIndent = indent + (isLast ? '  ' : '│ ');

  if (expr is BadExpr) {
    out += 'Bad\n';
  } else if (expr is NumberExpr) {
    out += 'Number(${expr.value})\n';
  } else if (expr is FoldExpr) {
    out += 'Fold (${expr.op})\n';

    for (final item in expr.list) {
      bool isLast = item == expr.list.last;
      out += newIndent + (isLast ? '╰─' : '├─');
      out += prettyPrint(item, newIndent, isLast);
    }
  } else if (expr is ChainExpr) {
    out += 'Chain\n';

    for (final (i, op) in expr.ops.indexed) {
      out += '$newIndent├─';
      out += prettyPrint(expr.list[i], newIndent, false);
      out += '$newIndent├─op: $op\n';
    }
    out += '$newIndent╰─';
    out += prettyPrint(expr.list.last, newIndent, true);
  } else {
    out += '${expr.runtimeType}\n';
  }

  return out;
}
