import 'package:flutter/material.dart';


class MyAlertDialog extends StatelessWidget {

  final String title;
  final String content;

  MyAlertDialog({
    this.title,
    this.content
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.black38)
        ),
        actions: [

          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              },
            label: Text(
              'Ok',
              style: TextStyle(color: Colors.black38),
            ),
            icon: Icon(Icons.close),
          )
        ]
    );
  }
}
