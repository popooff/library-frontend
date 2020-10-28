import 'package:flutter/material.dart';
import 'package:library_frontend/models/book.dart';
import 'package:library_frontend/services/rest_api/book_api.dart';


class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var searching = TextEditingController();
  var bookApi = BookApi();
  List<Book> books = [];


  @override
  void dispose() {
    searching.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Column(
              children: [

                Container(
                  height: 45,
                  child: TextField(
                    //controller: searching,
                    decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        labelText: 'Search',
                        border: OutlineInputBorder()
                    ),

                    onSubmitted: (value) async {
                      List<Book> _books = await bookApi.getBooks();

                      setState(() {
                        books = _books
                            .where((element) =>
                        element.title.toLowerCase().contains(value.toLowerCase())).toList();
                        /*|| element.author.toLowerCase().contains(value.toLowerCase()))*/

                      });

                    },
                  ),
                ),


                SizedBox(height: 10),

                Expanded(
                    child: ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {

                          return Card(
                            color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text('${books[index].title}'),
                              subtitle: Text('${books[index].author}'),
                              leading: Image.network('${bookApi.urlServer}/download/${books[index].cover}'),
                            ),
                          );
                        }),
                )
              ],
            )
          )
    );
  }
}
