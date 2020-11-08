import 'package:flutter/material.dart';
import 'package:library_frontend/models/book.dart';
import 'package:library_frontend/services/rest_api/reservation_api.dart';
import 'package:library_frontend/widgets/my_alert.dart';


class BookDescription extends StatefulWidget {

  final Book book;

  BookDescription({
    @required this.book,
  }) : assert(book != null, 'Il parametro formale \'Book\' non deve essere null');

  @override
  _BookDescriptionState createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {

  ReservationApi reservationApi;


  @override
  void initState() {
    reservationApi = ReservationApi();
    super.initState();
  }

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
                            'Book Info',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 20,
                            )
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                          'Autore: ${widget.book.author}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          )
                      ),

                      Text(
                          'Genere: ${widget.book.kind}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          )
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Trama: ${widget.book.plot}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        'Disponibili: ${widget.book.quantity}',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ]),
              ),
            ),
          )
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {

          if (widget.book.quantity > 0) {
            bool reserved = await reservationApi.addReservation(
                reservationApi.getUserId(),
                widget.book.id
            );

            if (reserved) {
              Navigator.pushNamedAndRemoveUntil(context, '/initial', (route) => false);
              showDialog(
                  context: context,
                  builder: (_) => MyAlertDialog(
                    content: 'Prenotazione effettuata con successo!',
                  )
              );

            } else {
              showDialog(
                  context: context,
                  builder: (_) => MyAlertDialog(
                    parent: context,
                    content: 'Errore, prenotazione non effettuata!',
                  )
              );
            }

          } else {
            showDialog(
                context: context,
                builder: (_) => MyAlertDialog(
                  content: 'Quantita esaurita!',
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
