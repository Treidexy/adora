class Syntax {}

class EqualSyntax {
  final String name;
  final Syntax value;

  EqualSyntax({required this.name, required this.value});
}

class ForSyntax {
  final Syntax inner;
  final List<EqualSyntax> substitutions;

  ForSyntax({required this.inner, required this.substitutions});
}

class WithSyntax {
  final Syntax inner;
  final List<EqualSyntax> substitutions;

  WithSyntax({required this.inner, required this.substitutions});
}
