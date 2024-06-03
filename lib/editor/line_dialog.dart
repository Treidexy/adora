import 'package:adora/editor/line_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  late final TextEditingController strokeController =
      TextEditingController(text: widget.data.stroke.toString());

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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 50,
                child: TextField(
                  controller: strokeController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    double? d = double.tryParse(value);
                    if (d != null) {
                      setState(() {
                        widget.callbacks.onChangeStroke(d);
                      });
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Slider(
                value: widget.data.stroke,
                onChanged: (value) {
                  setState(() {
                    strokeController.text = value.toStringAsFixed(2);
                    widget.callbacks.onChangeStroke(value);
                  });
                },
                min: 1,
                max: 25,
                label: '${widget.data.stroke}',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
