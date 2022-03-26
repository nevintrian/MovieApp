import 'package:flutter/material.dart';
import 'package:movies_app/components/drawer_component.dart';
import 'package:movies_app/pages/detail/detail_page.dart';
import 'package:movies_app/pages/search/search_page.dart';
import 'package:movies_app/pages/top_rated/top_rated_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({Key? key}) : super(key: key);
  static const routeName = '/toprated';

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  TopRatedModel topRatedModel = TopRatedModel();
  Future<List<dynamic>>? listMovie;

  Future<void> _pullRefresh() async {
    setState(() {
      listMovie = topRatedModel.get();
    });
  }

  @override
  void initState() {
    super.initState();
    listMovie = topRatedModel.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
            )
          ],
        ),
        drawer: const DrawerComponent(),
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
                  return RefreshIndicator(
                      color: Colors.blue,
                      onRefresh: _pullRefresh,
                      child: GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, DetailPage.routeName, arguments: {
                                  'id': snapshot.data[index]['id']
                                });
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
                          }));
                } else {
                  return const Center(
                      child: Text(
                    "Tidak ada data",
                    style: TextStyle(color: Colors.white),
                  ));
                }
              }
            }));
  }
}
    // return Card(
    //                           child: Column(
    //                             children: [
    //                               Container(
    //                                 height: 100,
    //                                 child: Image.network(
    //                                   'https://image.tmdb.org/t/p/original/${snapshot.data[index]['poster_path']}',
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ),
    //                               const SizedBox(
    //                                 height: 10,
    //                               ),
    //                               snapshot.data[index]['original_title'] != null
    //                                   ? Text(
    //                                       '${snapshot.data[index]['original_title']}')
    //                                   : Text(
    //                                       '${snapshot.data[index]['original_name']}'),
    //                               snapshot.data[index]['release_date'] != null
    //                                   ? Text(
    //                                       '${snapshot.data[index]['release_date']}')
    //                                   : Text(
    //                                       '${snapshot.data[index]['first_air_date']}'),
    //                             ],
    //                           ),
    //                         );