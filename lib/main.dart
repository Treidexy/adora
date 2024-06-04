import 'package:adora/adora_program.dart';
import 'package:adora/compiler/parser.dart';
import 'package:adora/compiler/syntax.dart';
import 'package:adora/editor/main_editor.dart';
import 'package:adora/main_painter.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

void main() {
  final parser = Parser("xyx = 7.7");
  print(parser.tokens);
  print((parser.parse() as EqualSyntax).value);
  // runApp(const MainApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final AdoraProgram program;
  final TransformationController transformationController =
      TransformationController();
  final SplitViewController splitViewController =
      SplitViewController(weights: [0.4], limits: [WeightLimit(min: 0.25)]);
  final GlobalKey canvasKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    program = AdoraProgram(onChange: () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adora"),
      ),
      body: SplitView(
        viewMode: SplitViewMode.Horizontal,
        controller: splitViewController,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 5),
              child: MainEditor(program)),
          InteractiveViewer(
            key: canvasKey,
            alignment: Alignment.center,
            constrained: false,
            minScale: 0.001,
            maxScale: double.maxFinite,
            transformationController: transformationController,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            child: CustomPaint(painter: MainPainter(program, canvasKey)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.center_focus_strong),
        onPressed: () {
          setState(() {
            transformationController.value = Matrix4.identity();
          });
        },
      ),
    );
  }
}
