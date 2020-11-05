import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class LibraryBottomBar extends StatelessWidget {

  final double borderRadius;
  final EdgeInsets margin, padding;
  final List<IconButton> bottoms;

  LibraryBottomBar({
    this.borderRadius = 30,
    this.margin = const EdgeInsets.only(
        left: 35,
        right: 35,
        bottom: 10
    ),
    this.padding = const EdgeInsets.all(5),
    @required this.bottoms
  });


  @override
  Widget build(BuildContext context) {

    return Container(
        margin: margin,
        padding: padding,
        height: 67,

        child: Card(
          color: Colors.blueGrey.withOpacity(0.35),

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: Colors.blueGrey)
          ),

          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: bottoms
          ),
        )
    );

  }
}
