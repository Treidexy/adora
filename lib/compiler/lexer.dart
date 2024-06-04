import 'package:adora/compiler/token.dart';
import 'package:flutter/material.dart';

class Lexer {
  final CharacterRange p;

  Lexer(String src) : p = src.characters.iterator..moveNext();

  Token lexNext() {
    while (p.current.contains(RegExp(r'\s'))) {
      p.moveNext();
    }

    switch (p.current) {
      case '(':
        p.moveNext();
        return LiteralToken(TokenKind.lparen);
      case ')':
        p.moveNext();
        return LiteralToken(TokenKind.rparen);
      case '[':
        p.moveNext();
        return LiteralToken(TokenKind.lbracket);
      case ']':
        p.moveNext();
        return LiteralToken(TokenKind.rbracket);
      case '{':
        p.moveNext();
        return LiteralToken(TokenKind.lbrace);
      case '}':
        p.moveNext();
        return LiteralToken(TokenKind.rbrace);

      case ',':
        p.moveNext();
        return LiteralToken(TokenKind.comma);
      case ';':
        p.moveNext();
        return LiteralToken(TokenKind.semicol);
      case ':':
        p.moveNext();
        return LiteralToken(TokenKind.colon);
      case '.':
        p.moveNext();
        if (p.current == '.') {
          p.moveBack();
          if (p.current == '=') {
            p.moveBack();
            return LiteralToken(TokenKind.dotdotequal);
          }

          return LiteralToken(TokenKind.dotdot);
        }
        return LiteralToken(TokenKind.dot);
      case '=':
        p.moveNext();
        return LiteralToken(TokenKind.equal);

      case '+':
        p.moveNext();
        return LiteralToken(TokenKind.plus);
      case '-':
        p.moveNext();
        return LiteralToken(TokenKind.minus);
      case '*':
        p.moveNext();
        return LiteralToken(TokenKind.star);
      case '/':
        p.moveNext();
        return LiteralToken(TokenKind.slash);
      case '%':
        p.moveNext();
        return LiteralToken(TokenKind.percent);
      case '|':
        p.moveNext();
        return LiteralToken(TokenKind.pipe);
      case '^':
        p.moveNext();
        return LiteralToken(TokenKind.caret);
      case '!':
        p.moveNext();
        return LiteralToken(TokenKind.bang);
    }

    if (p.current.contains(RegExp(r'\d'))) {
      return lexNumber();
    } else if (p.current.contains(RegExp(r'\w'))) {
      return lexNameOrKeyword();
    }

    return BadToken();
  }

  NumberToken lexNumber() {
    p.moveBack();
    final str = RegExp(r'\d').matchAsPrefix(p.stringAfter)!.input;
    p.moveNext(str.length);
    return NumberToken(double.parse(str));
  }

  Token lexNameOrKeyword() {
    p.moveBack();
    final str = RegExp(r'\w').matchAsPrefix(p.stringAfter)!.input;
    p.moveNext(str.length);

    switch (str) {
      case 'and':
        return LiteralToken(TokenKind.andKw);
      case 'or':
        return LiteralToken(TokenKind.orKw);
      case 'xor':
        return LiteralToken(TokenKind.xorKw);

      case 'with':
        return LiteralToken(TokenKind.withKw);
      case 'for':
        return LiteralToken(TokenKind.withKw);
      case 'is':
        return LiteralToken(TokenKind.withKw);
    }

    return NameToken(str);
  }
}
