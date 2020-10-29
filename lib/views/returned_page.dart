import 'package:flutter/material.dart';
import 'package:library_frontend/models/book.dart';
import 'package:library_frontend/services/rest_api/book_api.dart';
import 'package:library_frontend/services/rest_api/reservation_api.dart';


class ReturnedPage extends StatefulWidget {

  @override
  _ReturnedPageState createState() => _ReturnedPageState();
}

class _ReturnedPageState extends State<ReturnedPage> {

  ReservationApi reservationApi;
  BookApi bookApi;


  @override
  void initState() {
    reservationApi = ReservationApi();
    bookApi = BookApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: bookApi.getUserToBeReturnedBooks(bookApi.getUserId()),
          builder: (context, AsyncSnapshot<List<Book>> data) {

            if (data.data == null || data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );

            } else {
              return ListView.builder(
                  itemCount: (data.data == null) ? 0 : data.data.length,
                  //physics: ,
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
                            title: Text('${data.data[index].title}'),
                            subtitle: Text('${data.data[index].author.toString()}'),
                            leading: Icon(Icons.book_outlined),
                          ),

                          Padding(
                              padding: EdgeInsets.only(right: 5),
                            child: FlatButton(
                              onPressed: () async {
                                reservationApi.addReturned(bookApi.getUserId(), data.data[index].id);
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.check),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              );
            }

          },
        ),
      ),
    );
  }
}
