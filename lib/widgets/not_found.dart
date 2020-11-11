import 'package:flutter/material.dart';


class NotFound extends StatelessWidget {

  final String text;

  NotFound(this.text,);


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200,

      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.black38.withOpacity(0.4))
        ),
        child: Center(
          child: Text(text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5)
            ),
          ),
        ),
      ),
    );
  }

}
