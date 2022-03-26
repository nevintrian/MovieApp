import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/drawer_component.dart';
import 'package:movies_app/pages/detail/detail_page.dart';
import 'package:movies_app/pages/now_playing/now_playing_model.dart';
import 'package:movies_app/pages/now_playing/now_playing_page.dart';
import 'package:movies_app/pages/search/search_page.dart';
import 'package:movies_app/pages/top_rated/top_rated_model.dart';
import 'package:movies_app/pages/top_rated/top_rated_page.dart';
import 'package:movies_app/pages/upcoming/upcoming_model.dart';
import 'package:movies_app/pages/upcoming/upcoming_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NowPlayingModel nowPlayingModel = NowPlayingModel();
  TopRatedModel topRatedModel = TopRatedModel();
  UpcomingModel upcomingModel = UpcomingModel();
  Future<List<dynamic>>? listNowPlaying;
  Future<List<dynamic>>? listTopRated;
  Future<List<dynamic>>? listUpcoming;

  Future<void> _pullRefresh() async {
    setState(() {
      listNowPlaying = nowPlayingModel.get();
      listTopRated = topRatedModel.get();
      listUpcoming = upcomingModel.get();
    });
  }

  @override
  void initState() {
    super.initState();
    listNowPlaying = nowPlayingModel.get();
    listTopRated = topRatedModel.get();
    listUpcoming = upcomingModel.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
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
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Now Playing",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, NowPlayingPage.routeName);
                      },
                      child: const Text('MORE'))
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: FutureBuilder<List<dynamic>>(
                  future: listNowPlaying,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors
                                  .blue))); // Container that you just created
                    } else {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailPage.routeName,
                                      arguments: {
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
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Rated",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, TopRatedPage.routeName);
                      },
                      child: const Text('MORE'))
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: FutureBuilder<List<dynamic>>(
                  future: listTopRated,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors
                                  .blue))); // Container that you just created
                    } else {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailPage.routeName,
                                      arguments: {
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
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Upcoming",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, UpcomingPage.routeName);
                      },
                      child: const Text('MORE'))
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: FutureBuilder<List<dynamic>>(
                  future: listUpcoming,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors
                                  .blue))); // Container that you just created
                    } else {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailPage.routeName,
                                      arguments: {
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
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 200,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 200,
                    color: Colors.blue,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
