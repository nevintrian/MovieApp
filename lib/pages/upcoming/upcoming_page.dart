import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/drawer_component.dart';
import 'package:movies_app/pages/detail/detail_page.dart';
import 'package:movies_app/pages/search/search_page.dart';
import 'package:movies_app/pages/upcoming/upcoming_model.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);
  static const routeName = '/upcoming';

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  UpcomingModel upcomingModel = UpcomingModel();
  Future<List<dynamic>>? listMovie;

  Future<void> _pullRefresh() async {
    setState(() {
      listMovie = upcomingModel.get();
    });
  }

  @override
  void initState() {
    super.initState();
    listMovie = upcomingModel.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upcoming'),
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
