import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/pages/detail/detail_page.dart';
import 'package:movies_app/pages/search/search_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel = SearchModel();
  Future<List<dynamic>>? listMovie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            onChanged: (value) {
              setState(() {
                listMovie = searchModel.get(value);
              });
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {},
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
      body: FutureBuilder<List<dynamic>>(
          future: listMovie,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue))); // Container that you just created
            } else {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DetailPage.routeName,
                              arguments: {'id': snapshot.data[index]['id']});
                        },
                        child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${snapshot.data[index]['poster_path']}',
                              ),
                            )),
                      );
                    });
              } else {
                return const Center(
                    child: Text(
                  "Tidak ada data",
                  style: TextStyle(color: Colors.white),
                ));
              }
            }
          }),
    );
  }
}
