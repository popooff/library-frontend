import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final BuildContext parent;
  final String title;
  final String content;

  MyAlertDialog({this.parent, this.title = 'Info', @required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(content, style: TextStyle(color: Colors.black38)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black38)),
        actions: [
          FlatButton.icon(
            onPressed: () {
              if (parent == null) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.pop(parent);
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black38)),
            label: Text(
              'Close',
              style: TextStyle(color: Colors.black45),
            ),
            icon: Icon(
              Icons.close,
              color: Colors.black45,
            ),
          )
        ]);
  }
}
