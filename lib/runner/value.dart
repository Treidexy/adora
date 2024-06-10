abstract class Value {}

class NullValue extends Value {}

class ErrorValue extends Value {
  String msg;

  ErrorValue(this.msg);
}

class NumberValue extends Value {
  double value;

  NumberValue(this.value);
}

class ListValue extends Value {
  List<Value> list;

  ListValue(this.list);
}
