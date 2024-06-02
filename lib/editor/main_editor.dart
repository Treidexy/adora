import 'package:adora/adora_program.dart';
import 'package:adora/editor/line_editor.dart';
import 'package:flutter/material.dart';

class SwapNeighborIntent extends Intent {
  final int dx;

  const SwapNeighborIntent(this.dx);
}

class SwapLineIntent extends Intent {
  final int a, b;

  const SwapLineIntent(this.a, this.b);
}

class _SwapNeighborAction extends Action<SwapNeighborIntent> {
  final _MainEditorState editor;

  _SwapNeighborAction(this.editor);

  @override
  void invoke(SwapNeighborIntent intent) {
    int a = 0;
    for (var (i, line) in editor.lines.indexed) {
      if (line.focusNode.hasFocus) {
        a = i;
      }
    }

    int b = a + intent.dx;
    editor.swapNeighbor(a, b);
  }
}

class _SwapLineAction extends Action<SwapLineIntent> {
  final _MainEditorState editor;

  _SwapLineAction(this.editor);

  @override
  void invoke(SwapLineIntent intent) {
    editor.swapNeighbor(intent.a, intent.b);
  }
}

class MainEditor extends StatefulWidget {
  final AdoraProgram program;

  const MainEditor(this.program, {super.key});

  @override
  State createState() => _MainEditorState();
}

class _MainEditorState extends State<MainEditor> {
  List<LineData> lines = [];

  @override
  void initState() {
    super.initState();

    lines = [
      LineData(
        controller: TextEditingController(text: "(100, 20)"),
        focusNode: FocusNode(),
      ),
    ];
  }

  @override
  void dispose() {
    for (var line in lines) {
      line.focusNode.dispose();
    }

    super.dispose();
  }

  void newLineAndFocus({int? pos}) {
    setState(() {
      var focusNode = FocusNode();
      lines.insert(
          pos ?? lines.length,
          LineData(
            controller: TextEditingController(),
            focusNode: focusNode,
          ));
      focusNode.requestFocus();
    });
  }

  void swapNeighbor(int a, int b) {
    assert(a >= 0 && a < lines.length);

    if (b < 0 || b >= lines.length) {
      return;
    }

    setState(() {
      lines[a].focusNode.unfocus();
      lines[b].focusNode.unfocus();

      var tmp = lines[a];
      lines[a] = lines[b];
      lines[b] = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        SwapNeighborIntent: _SwapNeighborAction(this),
        SwapLineIntent: _SwapLineAction(this),
      },
      child: ListView(
        children: [
          for (var (i, line) in lines.indexed)
            LineEditor(
              lineNumber: i,
              data: line,
              onInsertLine: (_) {
                newLineAndFocus(pos: i + 1);
              },
              onChangeLine: () {
                widget.program
                    .parse([for (var line in lines) line.controller.text]);
              },
            ),
          Row(
            children: [
              const SizedBox(
                width: 50,
                child: ColoredBox(color: Colors.black),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: newLineAndFocus,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
