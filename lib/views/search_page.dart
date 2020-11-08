import 'package:flutter/material.dart';
import 'package:library_frontend/models/book.dart';
import 'package:library_frontend/services/rest_api/book_api.dart';
import 'package:library_frontend/views/book_description.dart';


// TODO aggiunge ingrandimento della copertina al tap di essa.
class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var searching;
  BookApi bookApi;
  List<Book> books;


  @override
  void initState() {
    searching = TextEditingController();
    bookApi = BookApi();
    super.initState();
  }

  @override
  void dispose() {
    searching.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Column(
              children: [

                Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search)
                    ),
                    onTap: () async {
                      books = await bookApi.getBooks();
                    },
                    onSubmitted: (value) {
                      setState(() {
                        books = books.where((element) =>
                          (element.title.toLowerCase().contains(value.toLowerCase())
                              || element.author.toString().toLowerCase().contains(value.toLowerCase()))
                        ).toList();
                      });
                    },
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: books == null ? 0 : books.length,
                      itemBuilder: (context, index) {

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.black.withOpacity(0.3))
                          ),

                          child: ListTile(
                            title: Text('${books[index].title}'),
                            subtitle: Text('${books[index].author}'),
                            leading: Image.network('${bookApi.urlServer}/download/${books[index].cover}'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => BookDescription(book: books[index]))
                              );
                            },
                          ),
                        );
                      }),
                )
              ])
        )
    );
  }

}
