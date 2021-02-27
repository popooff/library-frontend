import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_frontend/models/reservation.dart';
import 'package:library_frontend/services/rest_api/reservation_api.dart';


class BookedPage extends StatefulWidget {

  @override
  _BookedPageState createState() => _BookedPageState();
}

class _BookedPageState extends State<BookedPage> {

  ReservationApi reservationApi;


  @override
  void initState() {
    reservationApi = ReservationApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final List<Reservation> data = ModalRoute.of(context).settings.arguments;
    var backgroundImage = [
      Image.asset('assets/gif_1.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_2.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_3.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_4.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_5.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_6.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_7.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_8.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_9.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_10.gif', fit: BoxFit.cover),
      Image.asset('assets/gif_11.gif', fit: BoxFit.cover),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Prenotati', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey.withOpacity(0.35),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: SafeArea(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: (data == null) ? 0 : data.length,
              itemBuilder: (context, index) {

                return Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ExpansionCard(
                    borderRadius: 10,
                    background: (backgroundImage..shuffle()).first,
                    margin: EdgeInsets.only(top: 5),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data[index].book.title}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Text(
                            "Autore: ${data[index].book.getAuthors()}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.70)),
                          ),
                        ],
                      ),
                    ),

                    children: [

                      Container(
                        child: Text("Libro prenotato nelle date:",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.75)
                            )
                        ),
                      ),

                      Container(
                        child: Text(data[index].getBookedDates(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.75)
                            )
                        ),
                      ),

                    ]),
                );
              })
      ),
    );
  }

}
