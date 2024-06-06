import 'package:adora/runner/value.dart';

class Scope {
  final Scope? parent;
  final Map<String, Value> variables = {};

  Scope(this.parent);

  Value addVar(String name, Value value) {
    return variables[name] = value;
  }

  Value? getVar(String name) {
    return variables[name] ?? parent?.getVar(name);
  }
}
