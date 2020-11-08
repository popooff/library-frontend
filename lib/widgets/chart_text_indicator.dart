import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class ChartTextIndicator extends StatelessWidget {

  final Color backgroundColor;
  final String text;
  final double containerSize;
  final Color textColor;

  const ChartTextIndicator({
    this.backgroundColor,
    @required this.text,
    this.containerSize = 20,
    this.textColor = Colors.black54,
  });


  @override
  Widget build(BuildContext context) {

    return Row(
        children: [

          Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
          ),

          const SizedBox(width: 5),

          Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor
            ),
          )
        ]);

  }
}
