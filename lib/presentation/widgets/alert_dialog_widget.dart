import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {

  final String title;
  final String content;
  final Function onPressedYes;

  const AlertDialogWidget({Key key, @required this.title, @required this.content, @required this.onPressedYes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content:
          Text(content),
      actions: [
        FlatButton(
          textColor: Color(0xFF6200EE),
          onPressed: () => Navigator.of(context).pop(),
          child: Text('NO'),
        ),
        FlatButton(
          textColor: Color(0xFF6200EE),
          onPressed: onPressedYes,
          child: Text('SI'),
        ),
      ],
    );
  }
}
