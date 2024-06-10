import 'package:adora/editor/line_dialog.dart';
import 'package:adora/editor/main_editor.dart';
import 'package:adora/runner/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LineData {
  static const double defaultStroke = 5;

  TextEditingController controller;
  FocusNode focusNode;
  Color color;
  double stroke;
  Value value;

  LineData({
    required this.controller,
    required this.focusNode,
    required this.color,
    required this.value,
    this.stroke = defaultStroke,
  });
}

class LineEditor extends StatelessWidget {
  final void Function(String) onInsert;
  final void Function() onChange;
  final void Function() onDelete;
  final LineData data;
  final int lineNumber;

  final LineDialogCallbacks dialogCallbacks;

  const LineEditor({
    super.key,
    required this.lineNumber,
    required this.data,
    required this.onInsert,
    required this.onChange,
    required this.onDelete,
    required this.dialogCallbacks,
  });

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
        SizedBox(
          width: 50,
          child: Row(
            children: [
              Text('$lineNumber'),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: LineDialog(
                              data: data,
                              callbacks: dialogCallbacks,
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: data.color,
                  )),
            ],
          ),
        ),
        Expanded(
          child: TextField(
            controller: data.controller,
            focusNode: data.focusNode,
            onSubmitted: onInsert,
            onChanged: (_) => onChange(),
          ),
        ),
        IconButton(onPressed: onDelete, icon: const Icon(Icons.close)),
      ]),
    );
  }
}
