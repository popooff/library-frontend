import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../models/book.dart';
import '../services/rest_api/reservation_api.dart';


class BookDescription extends StatelessWidget {

  final Book book;


  BookDescription({
    @required this.book,
  }) : assert(book != null, 'Il parametro formale \'Book\' non deve essere null');


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(
                        child: Text(
                            'Informazioni',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 20,
                            )
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                          'Autore: ${book.author}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.grey,
                            fontSize: 15,
                          )
                      ),

                      Text(
                          'Genere: ${book.kind}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.grey,
                            fontSize: 15,
                          )
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Trama: ${book.plot}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        'Disponibili: ${book.quantity}',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black38,
                          fontSize: 16,
                        ),
                      ),
                    ]),
              ),
            ),
          )
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {

          if (book.quantity > 0) {
            bool reserved = await ReservationApi().addReservation(ReservationApi().getUserId(), book.id);

            if (reserved) {
              Navigator.pushNamedAndRemoveUntil(context, '/initial', (route) => false);
            }

          } else {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    title: Text("Info"),
                    content: Text("Quantità esaurita!"),
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
                )
            );
          }
        },

        icon: Icon(Icons.add),
        label: Text('Prenota'),
        backgroundColor: Colors.blueAccent.withOpacity(0.5),
      ),
    );

  }
}
