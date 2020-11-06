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

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: (data == null) ? 0 : data.length,
            itemBuilder: (context, index) {

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black38)
                ),

                child: ListTile(
                  title: Text('${data[index].book.title.toString()}'),
                  subtitle: Text('${data[index].book.kind.toString()}'),
                  leading: Icon(Icons.book_outlined),
                ),
              );
            })
      ),
    );
  }

}
