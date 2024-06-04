import 'package:adora/compiler/lexer.dart';
import 'package:adora/compiler/syntax.dart';
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

  Syntax parse() {
    switch (current.kind) {
      case TokenKind.name:
        String name = (_next() as NameToken).name;
        return _parseAfterName(name);
      case TokenKind.number:
        double value = (_next() as NumberToken).value;
        return NumberSyntax(value);
      default:
        return BadSyntax();
    }
  }

  Syntax _parseAfterName(String name) {
    switch (current.kind) {
      case TokenKind.equal:
        _next();
        final value = parse();
        return EqualSyntax(name: name, value: value);
      default:
        return NameSyntax(name: name);
    }
  }

  Token _next() {
    if (i + 1 >= tokens.length) {
      return tokens[i = tokens.length - 1];
    }

    return tokens[i++];
  }

  Token? _match(List<TokenKind> kinds) {
    if (kinds.contains(current.kind)) {
      return _next();
    }

    return null;
  }
}
