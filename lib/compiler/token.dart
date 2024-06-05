import 'dart:math';

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

  lt,
  le,
  gt,
  ge,

  andKw,
  orKw,
  xorKw,

  withKw,
  forKw,
  isKw;
}

extension TokenExt on Token {
  bool get isOp => isFoldOp || isChainOp;

  bool get isFoldOp => [
        TokenKind.plus,
        TokenKind.star,
        TokenKind.pipe,
        TokenKind.andKw,
        TokenKind.orKw,
        TokenKind.xorKw,
        TokenKind.comma,
        // Non-Associative
        TokenKind.minus,
        TokenKind.slash,
        TokenKind.percent,
        TokenKind.caret,
        TokenKind.arrow,
        TokenKind.dot,
      ].contains(kind);

  bool get isChainOp => [
        TokenKind.lt,
        TokenKind.le,
        TokenKind.gt,
        TokenKind.ge,
        TokenKind.equal,
      ].contains(kind);

  int get precedence => [
        [
          TokenKind.comma,
        ],
        [
          TokenKind.arrow,
        ],
        [
          TokenKind.andKw,
          TokenKind.orKw,
          TokenKind.xorKw,
        ],
        [
          TokenKind.lt,
          TokenKind.le,
          TokenKind.gt,
          TokenKind.ge,
          TokenKind.equal,
        ],
        [
          TokenKind.pipe,
        ],
        [
          TokenKind.plus,
          TokenKind.minus,
        ],
        [
          TokenKind.star,
          TokenKind.slash,
          TokenKind.percent,
        ],
        [
          TokenKind.caret,
        ],
        [
          TokenKind.dot,
        ]
      ].indexed.fold(
            0,
            (a, combo) => max(a, combo.$2.contains(kind) ? combo.$1 + 1 : 0),
          );
}

abstract class Token {
  final TokenKind kind;

  Token(this.kind);
}

class BadToken extends Token {
  BadToken() : super(TokenKind.unknown);

  @override
  String toString() {
    return kind.name;
  }
}

class EofToken extends Token {
  EofToken() : super(TokenKind.eof);

  @override
  String toString() {
    return kind.name;
  }
}

class LiteralToken extends Token {
  LiteralToken(super.kind);

  @override
  String toString() {
    return kind.name;
  }

  @override
  bool operator ==(Object other) {
    if (other is! LiteralToken) return false;
    return other.kind == kind;
  }

  @override
  int get hashCode => kind.hashCode;
}

class NameToken extends Token {
  final String name;

  NameToken(this.name) : super(TokenKind.name);
  @override
  String toString() {
    return 'Name($name)';
  }

  @override
  bool operator ==(Object other) {
    if (other is! NameToken) return false;
    return other.name == name;
  }

  @override
  int get hashCode => Object.hash(kind, name);
}

class NumberToken extends Token {
  final double value;

  NumberToken(this.value) : super(TokenKind.number);

  @override
  String toString() {
    return 'Number($value)';
  }

  @override
  bool operator ==(Object other) {
    if (other is! NumberToken) return false;
    return other.value == value;
  }

  @override
  int get hashCode => Object.hash(kind, value);
}
