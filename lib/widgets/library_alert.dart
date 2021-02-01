import 'package:flutter/material.dart';


class LibraryAlert extends StatelessWidget {

  final AlertDialogType type;
  final String title;
  final String content;
  final Widget icon;
  final String buttonLabel;

  LibraryAlert({
    Key key,
    this.title = "Info",
    @required this.content,
    this.icon,
    this.type = AlertDialogType.INFO,
    this.buttonLabel = "Ok"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                icon ??
                    Icon(
                      _getIconForType(type),
                      color: _getColorForType(type),
                      size: 40,
                    ),

                const SizedBox(height: 10.0),

                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 5),

                Text(
                  content,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(buttonLabel),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),

              ]),
          ),
        )
    );
  }


  IconData _getIconForType(AlertDialogType type) {

    switch (type) {

      case AlertDialogType.WARNING:
        return Icons.warning;

      case AlertDialogType.SUCCESS:
        return Icons.check_circle;

      case AlertDialogType.ERROR:
        return Icons.error;

      case AlertDialogType.INFO:
      default:
        return Icons.info_outline;
    }
  }


  Color _getColorForType(AlertDialogType type) {

    switch (type) {

      case AlertDialogType.WARNING:
        return Colors.orange;

      case AlertDialogType.SUCCESS:
        return Colors.green;

      case AlertDialogType.ERROR:
        return Colors.red;

      case AlertDialogType.INFO:
      default:
        return Colors.blue;
    }
  }

}



enum AlertDialogType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}
