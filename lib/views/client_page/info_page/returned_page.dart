import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_frontend/models/reservation.dart';
import 'package:library_frontend/services/rest_api/reservation_api.dart';
import 'package:library_frontend/widgets/library_alert.dart';


class ReturnedPage extends StatefulWidget {

  @override
  _ReturnedPageState createState() => _ReturnedPageState();
}

class _ReturnedPageState extends State<ReturnedPage> {

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

    final List<Reservation> data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: (data == null) ? 0 : data.length,
              itemBuilder: (context, index) {

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.black38)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        title: Text('${data[index].book.title.toString()}'),
                        subtitle: Text('${data[index].book.kind.toString()}'),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                            '${reservationApi.urlServer}/download/${data[index].book.cover}',
                            headers:reservationApi.authHeader(token),
                          ),
                        )
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: FlatButton(

                          onPressed: () async {
                            bool returned = await reservationApi.returnBook(data[index].idReservation);

                            if (returned) {
                              setState(() {
                                data.removeAt(index);
                              });

                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LibraryAlert(
                                    type: AlertDialogType.WARNING,
                                    content: "Problemi con la restituzione del libro!",
                                  );
                                },
                              );
                            }
                          },

                          child: Text('Restituisci', style: TextStyle(color: Colors.black54),),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black.withOpacity(0.5))
                          ),
                        ),
                      )
                    ]),
                );
              })
      ),
    );
  }

}
