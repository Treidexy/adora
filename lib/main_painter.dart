import 'package:adora/adora_program.dart';
import 'package:flutter/material.dart';

class MainPainter extends CustomPainter {
  final AdoraProgram program;

  MainPainter(this.program);

  @override
  void paint(Canvas canvas, Size size) {
    // print(canvas.getTransform());
    canvas.drawColor(const Color(0xFF404040), BlendMode.src);

    canvas.drawRect(
      Rect.fromCircle(center: Offset.zero, radius: 5),
      Paint()..color = Colors.green,
    );

    for (var point in program.points) {
      canvas.drawCircle(
        Offset(point.x, point.y),
        5 / canvas.getTransform().first,
        Paint()..color = Colors.red,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
