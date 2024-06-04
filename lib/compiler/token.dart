enum TokenKind {
  unknown,
  eof,
  name,
  number,

  lparen,
  rparen,
  lbracket,
  rbracket,
  lbrace,
  rbrace,

  comma,
  semicol,
  colon,
  dot,
  dotdot,
  dotdotequal,
  equal,

  plus,
  minus,
  star,
  slash,
  percent,
  pipe,
  caret,
  bang,

  arrow,
  squigglyArrow,

  andKw,
  orKw,
  xorKw,

  withKw,
  forKw,
  isKw,
}

abstract class Token {
  final TokenKind kind;

  Token(this.kind);
}

class BadToken extends Token {
  BadToken() : super(TokenKind.unknown);
}

class EofToken extends Token {
  EofToken() : super(TokenKind.eof);
}

class LiteralToken extends Token {
  LiteralToken(super.kind);
}

class NameToken extends Token {
  final String name;

  NameToken(this.name) : super(TokenKind.name);
}

class NumberToken extends Token {
  final double value;

  NumberToken(this.value) : super(TokenKind.number);
}
