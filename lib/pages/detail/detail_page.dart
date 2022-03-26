import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/pages/detail/detail_model.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(Object? arguments, {Key? key}) : super(key: key);
  static const routeName = '/detail';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var formatter = DateFormat('dd-MM-yyyy');
  DetailModel detailModel = DetailModel();
  Future<LinkedHashMap>? listMovie;

  @override
  Widget build(BuildContext context) {
    String args =
        (ModalRoute.of(context)?.settings.arguments as Map)['id'].toString();
    listMovie = detailModel.get(args);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: FutureBuilder<LinkedHashMap>(
            future: listMovie,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue))); // Container that you just created
              } else {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 200,
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                                'https://image.tmdb.org/t/p/original/${snapshot.data['poster_path']}',
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(20),
                          height: 300,
                          width: 500,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data['original_title']}',
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                formatter.format(DateTime.parse(
                                    snapshot.data['release_date'])),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('${snapshot.data['overview']}'),
                            ],
                          )),
                    ],
                  );
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
