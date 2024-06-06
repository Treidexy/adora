import 'package:adora/editor/line_editor.dart';
import 'package:flutter/material.dart';

class LineEditorFeedback extends StatelessWidget {
  final LineData data;
  final int lineNumber;

  const LineEditorFeedback({
    super.key,
    required this.data,
    required this.lineNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 700,
        child: Row(children: [
          SizedBox(
            width: 50,
            child: Row(
              children: [
                Text('$lineNumber'),
                IconButton(
                    onPressed: null,
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
            ),
          ),
          const IconButton(onPressed: null, icon: Icon(Icons.close)),
        ]),
      ),
    );
  }
}
