import 'package:adora/compiler/token.dart';

class Lexer {
  final String src;
  int i = 0;

  String get current => src[i];
  String get substring => src.substring(i);

  Lexer(this.src);

  Token lexNext() {
    _match(r'\s+');

    if (i == src.length) {
      return EofToken();
    }

    switch (current) {
      case '(':
        _next();
        return LiteralToken(TokenKind.lparen);
      case ')':
        _next();
        return LiteralToken(TokenKind.rparen);
      case '[':
        _next();
        return LiteralToken(TokenKind.lbracket);
      case ']':
        _next();
        return LiteralToken(TokenKind.rbracket);
      case '{':
        _next();
        return LiteralToken(TokenKind.lbrace);
      case '}':
        _next();
        return LiteralToken(TokenKind.rbrace);

      case ',':
        _next();
        return LiteralToken(TokenKind.comma);
      case ';':
        _next();
        return LiteralToken(TokenKind.semicol);
      case ':':
        _next();
        return LiteralToken(TokenKind.colon);
      case '.':
        _next();
        if (current == '.') {
          _next();
          if (current == '=') {
            _next();
            return LiteralToken(TokenKind.dotdotequal);
          }

          return LiteralToken(TokenKind.dotdot);
        }
        return LiteralToken(TokenKind.dot);
      case '=':
        _next();
        return LiteralToken(TokenKind.equal);

      case '+':
        _next();
        return LiteralToken(TokenKind.plus);
      case '-':
        _next();
        if (current == '>') {
          _next();
          return LiteralToken(TokenKind.arrow);
        }
        return LiteralToken(TokenKind.minus);
      case '*':
        _next();
        return LiteralToken(TokenKind.star);
      case '/':
        _next();
        return LiteralToken(TokenKind.slash);
      case '%':
        _next();
        return LiteralToken(TokenKind.percent);
      case '|':
        _next();
        return LiteralToken(TokenKind.pipe);
      case '^':
        _next();
        return LiteralToken(TokenKind.caret);
      case '!':
        _next();
        return LiteralToken(TokenKind.bang);

      case '<':
        _next();
        if (current == '=') {
          _next();
          return LiteralToken(TokenKind.le);
        }
        return LiteralToken(TokenKind.lt);
      case '>':
        _next();
        if (current == '=') {
          _next();
          return LiteralToken(TokenKind.ge);
        }
        return LiteralToken(TokenKind.gt);
    }

    var match = _match(r'\d+(\.\d+)?(e[\+-]\d+)?');
    if (match != null) {
      return NumberToken(double.parse(match));
    }

    match = _match(r'[\w_]+');
    if (match != null) {
      switch (match) {
        case 'and':
          return LiteralToken(TokenKind.andKw);
        case 'or':
          return LiteralToken(TokenKind.orKw);
        case 'xor':
          return LiteralToken(TokenKind.xorKw);
        case 'with':
          return LiteralToken(TokenKind.withKw);
        case 'for':
          return LiteralToken(TokenKind.forKw);
        case 'is':
          return LiteralToken(TokenKind.isKw);
        default:
          return NameToken(match);
      }
    }

    _next();
    return BadToken();
  }

  String _next() {
    final c = current;
    if (++i > src.length) {
      i = src.length;
    }

    return c;
  }

  String? _match(String regex) {
    final match = RegExp(regex).matchAsPrefix(substring)?.group(0);
    if (match != null) {
      i += match.length;
    }

    return match;
  }
}
