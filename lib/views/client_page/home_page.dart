import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_frontend/models/book.dart';
import 'package:library_frontend/services/rest_api/book_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'info_page/book_description.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  BookApi bookApi;
  String token;
  List<Book> books = [];
  int start = 0, end = 8;
  var _controller = ScrollController();

  @override
  void initState() {
    bookApi = BookApi();
    getToken();
    super.initState();

    _controller.addListener(() {
      if (_controller.position.atEdge) {

        if (_controller.position.pixels != 0) {
          fetchBooks();
        }
      }
    });
  }

  void getToken() async {
    String jwt = await bookApi.getToken();
    var book = await bookApi.getBook(start, end);

    setState(() {
      token = jwt;
      books.addAll(book);
    });
  }

  void fetchBooks() async {

    start += 9;
    end += 8;

    List<Book> book = await bookApi.getBook(start, end);

    if (book.isNotEmpty) {

      setState(() {
        books.addAll(book);
      });
    }

    start += 9;
    end += 8;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,

      child: StaggeredGridView.countBuilder(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 4,
          itemCount:books.length,
          controller: _controller,
          itemBuilder: (context, index) {

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black38)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(

                  child: Image(image: CachedNetworkImageProvider(
                    "${bookApi.urlServer}/download/${books[index].cover}",
                    headers:bookApi.authHeader(token),
                  )
                  ),

                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) {
                              return BookDescription(book: books[index]);
                            })
                    );},
                ),
              ),
            );
          },

          staggeredTileBuilder: (int index) => StaggeredTile.fit(2)
      ),

    );

  }
}
