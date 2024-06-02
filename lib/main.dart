import 'package:adora/editor/main_editor.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, 100, 100),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("say gex"),
      ),
      body: SplitView(
        viewMode: SplitViewMode.Horizontal,
        controller: SplitViewController(limits: [WeightLimit(min: 0.25)]),
        children: [
          const Padding(padding: EdgeInsets.only(left: 5), child: MainEditor()),
          CustomPaint(painter: MainPainter()),
        ],
      ),
    );
  }
}
