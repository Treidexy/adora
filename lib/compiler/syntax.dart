abstract class Syntax {}

class BadSyntax extends Syntax {}

class NameSyntax extends Syntax {
  final String name;

  NameSyntax({required this.name});
}

class NumberSyntax extends Syntax {
  final double value;

  NumberSyntax(this.value);
}

class EqualSyntax extends Syntax {
  final String name;
  final Syntax value;

  EqualSyntax({required this.name, required this.value});
}

class ForSyntax extends Syntax {
  final Syntax inner;
  final List<EqualSyntax> substitutions;

  ForSyntax({required this.inner, required this.substitutions});
}

class WithSyntax extends Syntax {
  final Syntax inner;
  final List<EqualSyntax> substitutions;

  WithSyntax({required this.inner, required this.substitutions});
}
