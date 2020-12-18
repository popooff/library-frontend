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
  String token;

  @override
  void initState() {
    reservationApi = ReservationApi();
    getToken();
    super.initState();
  }

  void getToken() async {
    String jwt = await reservationApi.getToken();

    setState(() {
      token = jwt;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [

          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 500,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                child: Image.network(
                  '${reservationApi.urlServer}/download/${widget.book.cover}',
                  headers: reservationApi.authHeader(token),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SliverList(
              delegate: SliverChildListDelegate([

                SizedBox(
                  height: 5,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
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
                ),

                SizedBox(height: 10),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                      'Autore: ${widget.book.getAuthors()}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                      'Genere: ${widget.book.kind}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      )
                  ),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Trama: ${widget.book.plot}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Disponibili: ${widget.book.quantity}',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                )
              ])
          )

        ]
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {

          if (widget.book.quantity > 0) {
            bool reserved = await reservationApi.addReservation(
                reservationApi.getUserId(),
                widget.book.id
            );

            if (reserved) {

              setState(() {
                widget.book.quantity--;
              });

              showDialog(
                  context: context,
                  builder: (_) => MyAlertDialog(
                    parent: context,
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
