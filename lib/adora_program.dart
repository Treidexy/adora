import 'dart:math';

class AdoraProgram {
  final List<Point<double>> points = [];
  final Function onChange;

  AdoraProgram({required this.onChange});

  void parse(Iterable<String> lines) {
    points.clear();

    for (var line in lines) {
      line.trim();
      int open = line.indexOf('(');
      int comma = line.indexOf(',');
      int close = line.indexOf(')');

      if (open == -1 || comma == -1 || close == -1) {
        continue;
      }

      double x = double.parse(line.substring(open + 1, comma));
      double y = double.parse(line.substring(comma + 1, close));
      points.add(Point(x, y));
    }

    onChange();
  }
}
