import 'package:adora/runner/adora_program.dart';
import 'package:flutter/material.dart';

class MainPainter extends CustomPainter {
  final AdoraProgram program;
  final GlobalKey canvasKey;
  Size get size => canvasKey.currentContext?.size ?? const Size.square(1);

  MainPainter(this.program, this.canvasKey);

  @override
  void paint(Canvas canvas, Size _) {
    canvas.scale(size.width / 20);
    canvas.translate(10, 10 / size.aspectRatio);
    canvas.scale(1, -1);
    final double scale = canvas.getTransform().first;

    // print(canvas.getTransform());
    canvas.drawColor(const Color(0xFFFFFFFF), BlendMode.src);

    final Paint axisPaint = Paint()..color = Colors.black;
    canvas.drawLine(
      const Offset(-9999999999, 0),
      const Offset(9999999999, 0),
      axisPaint,
    );
    canvas.drawLine(
      const Offset(0, -9999999999),
      const Offset(0, 9999999999),
      axisPaint,
    );

    // ignore: dead_code
    if (false) {
      final textPainter = TextPainter(
        text: const TextSpan(
            text: '0', style: TextStyle(fontSize: 12, color: Colors.black)),
        textScaler: TextScaler.linear(1 / scale),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-2 / scale - textPainter.width, 10 / scale));

      for (double x = -10; x <= 10; x++) {
        if (x == 0) continue;

        final textPainter = TextPainter(
          text: TextSpan(
              text: x.toStringAsFixed(0),
              style: const TextStyle(fontSize: 12, color: Colors.black)),
          textScaler: TextScaler.linear(1 / scale),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
            canvas, Offset(x - textPainter.width / 2, 10 / scale));
        textPainter.layout();
        textPainter.paint(canvas,
            Offset(-2 / scale - textPainter.width, x - textPainter.height / 2));
      }
    }

    for (var (pos, color, stroke) in program.state.points) {
      canvas.drawCircle(
        pos,
        stroke / scale,
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
