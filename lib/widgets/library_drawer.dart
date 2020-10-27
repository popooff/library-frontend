import 'package:flutter/material.dart';


class LibraryDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
          padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
          children: [

            DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/drawer_image.jpg')
                    )
                ),

                child: Text(
                  "Library",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                  ),
                )
            ),

            ListTile(
                title: Text('Libri'),
                subtitle: Text('Prenotati'),
                leading: Icon(Icons.playlist_add_check),
                onTap: () {
                  Navigator.pushNamed(context, '/reservation');
                }),

            ListTile(
                title: Text('Libri'),
                subtitle: Text('Da restituire'),
                leading: Icon(Icons.keyboard_return),
                onTap: () {
                  Navigator.pushNamed(context, '/return');
                }),
          ]
      ),
    );

  }
}
