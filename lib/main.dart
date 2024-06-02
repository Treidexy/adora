import 'package:adora/adora_program.dart';
import 'package:adora/editor/main_editor.dart';
import 'package:adora/main_painter.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final AdoraProgram program;
  TransformationController transformationController =
      TransformationController();

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
        controller: SplitViewController(limits: [WeightLimit(min: 0.25)]),
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 5),
              child: MainEditor(program)),
          InteractiveViewer(
            alignment: Alignment.center,
            constrained: false,
            transformationController: transformationController,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            child: CustomPaint(painter: MainPainter(program)),
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
