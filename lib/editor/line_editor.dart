import 'package:adora/editor/main_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LineData {
  TextEditingController controller;
  FocusNode focusNode;

  LineData({required this.controller, required this.focusNode});
}

class LineEditor extends StatefulWidget {
  final void Function(String) onInsertLine;
  final LineData data;
  final int lineNumber;

  const LineEditor(
      {super.key,
      required this.lineNumber,
      required this.data,
      required this.onInsertLine});

  @override
  State createState() => _LineEditorState();
}

class _LineEditorState extends State<LineEditor> {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.arrowUp, alt: true):
            SwapNeighborIntent(-1),
        SingleActivator(LogicalKeyboardKey.arrowDown, alt: true):
            SwapNeighborIntent(1),
      },
      child: Row(children: [
        Text('${widget.lineNumber}'),
        SizedBox(
          width: 50,
          child: IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.edit)),
        ),
        Expanded(
          child: TextField(
            controller: widget.data.controller,
            focusNode: widget.data.focusNode,
            onSubmitted: widget.onInsertLine,
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.close)),
      ]),
    );
  }
}
