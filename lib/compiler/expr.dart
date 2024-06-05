import 'package:adora/compiler/token.dart';

abstract class Expr {}

class BadExpr extends Expr {}

class NameExpr extends Expr {
  final String name;

  NameExpr(this.name);
}

class NumberExpr extends Expr {
  final double value;

  NumberExpr(this.value);
}

class FoldExpr extends Expr {
  final Token op;
  final List<Expr> list;

  FoldExpr(this.op, this.list);
}

class ChainExpr extends Expr {
  final List<Token> ops;
  final List<Expr> list;

  ChainExpr(this.ops, this.list);
}

class ListExpr extends Expr {
  final List<Expr> list;

  ListExpr(this.list);
}
