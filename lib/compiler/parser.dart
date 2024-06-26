import 'package:adora/compiler/lexer.dart';
import 'package:adora/compiler/expr.dart';
import 'package:adora/compiler/parse_error.dart';
import 'package:adora/compiler/token.dart';

class Parser {
  Token get current => tokens[i];
  final List<Token> tokens = [];
  int i = 0;

  Parser(String src) {
    final lexer = Lexer(src);

    do {
      tokens.add(lexer.lexNext());
    } while (tokens.last.kind != TokenKind.eof);
  }

  Expr parse([int precedence = 0]) {
    var begin = _parseTerm();

    if (current.kind == TokenKind.lparen) {
      final arg = _parseTerm();
      begin = CallExpr(begin, arg);
    }

    while (current.kind.precedence > precedence) {
      if (current.kind.isChainOp) {
        begin = _parseChain(begin);
        continue;
      }

      if (current.kind.isFoldOp) {
        begin = _parseFold(begin);
        continue;
      }
    }

    return begin;
  }

  Expr _parseTerm() {
    switch (current.kind) {
      case TokenKind.name:
        String name = (_next() as NameToken).name;
        return NameExpr(name);
      case TokenKind.number:
        double value = (_next() as NumberToken).value;
        return NumberExpr(value);
      case TokenKind.lparen:
        _next();
        final inner = parse();
        final close = _match(TokenKind.rparen);
        if (close == null) {
          throw ParseError('unclosed paren');
        }
        return inner;
      default:
        throw ParseError('bad token: $current');
      // return BadExpr();
    }
  }

  Expr _parseFold(Expr begin) {
    List<Expr> list = [begin];
    Token op = _next();

    do {
      list.add(parse(op.kind.precedence));
    } while (_matchExact(op) != null);

    if (op.kind == TokenKind.comma) {
      return ListExpr(list);
    }

    return FoldExpr(op, list);
  }

  Expr _parseChain(Expr begin) {
    List<Expr> list = [begin];
    List<Token> ops = [];

    while (current.kind.isChainOp) {
      ops.add(_next());
      list.add(parse(ops.last.kind.precedence));
    }

    return ChainExpr(ops, list);
  }

  Token _next() {
    if (i + 1 >= tokens.length) {
      return tokens[i = tokens.length - 1];
    }

    return tokens[i++];
  }

  Token? _match(TokenKind kind) {
    if (current.kind == kind) {
      return _next();
    }

    return null;
  }

  Token? _matchExact(Token token) {
    if (current == token) {
      return _next();
    }

    return null;
  }
}
