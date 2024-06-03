import 'package:adora/editor/line_editor.dart';
import 'package:flutter/material.dart';

class LineDialogCallbacks {
  final void Function(Color) onChangeColor;
  final void Function(double) onChangeStroke;

  LineDialogCallbacks(
      {required this.onChangeColor, required this.onChangeStroke});
}

class LineDialog extends StatefulWidget {
  final LineData data;
  final LineDialogCallbacks callbacks;

  const LineDialog({super.key, required this.data, required this.callbacks});

  @override
  State createState() => _LineDialogState();
}

class _LineDialogState extends State<LineDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OverflowBar(
          children: [
            for (Color color in [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.purple,
              Colors.black
            ])
              IconButton(
                onPressed: () {
                  widget.callbacks.onChangeColor(color);
                },
                icon: const Icon(Icons.brush),
                color: color,
              ),
          ],
        ),
        Slider(
          value: widget.data.stroke,
          onChanged: (value) {
            setState(() {
              widget.callbacks.onChangeStroke(value);
            });
          },
          min: 1,
          max: 25,
          label: '${widget.data.stroke}',
        ),
      ],
    );
  }
}
