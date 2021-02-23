import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:library_frontend/services/rest_api/reservation_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:library_frontend/widgets/library_alert.dart';
import 'package:library_frontend/models/reservation.dart';
import 'package:flutter/material.dart';


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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Restituire', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey.withOpacity(0.35),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: SafeArea(
        child: StaggeredGridView.countBuilder(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 4,
            itemCount:data == null ? 0 : data.length,
            itemBuilder: (context, index) {

              return Stack(
                children: [

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black38)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                          image: CachedNetworkImageProvider(
                            '${reservationApi.urlServer}/download/${data[index].book.cover}',
                            headers: reservationApi.authHeader(token),
                          )
                      ),

                    ),
                  ),

                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: FlatButton(

                      onPressed: () async {

                        setState(() => data[index].loading = true);
                        bool returned = await reservationApi.returnBook(data[index].idReservation);

                        if (returned) {
                          setState(() {
                            data[index].loading = false;
                            data[index].returned = returned;
                          });

                          await Future.delayed(Duration(seconds: 1));

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LibraryAlert(
                                type: AlertDialogType.SUCCESS,
                                content: "Restituzione avvenuta!",
                              );
                            },
                          );

                        } else {

                          setState(() {
                            data[index].loading = false;
                          });

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

                      child: data[index].loading ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )) : data[index].returned ? Icon(Icons.check, color: Colors.green) : Text('Restituisci', style: TextStyle(color: Colors.black87)),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.black87)
                      ),
                    ),
                  )

                ],
              );
            },

            staggeredTileBuilder: (int index) => StaggeredTile.fit(2)
        ),
      ),
    );
  }

}
