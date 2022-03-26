import 'package:flutter/material.dart';
import 'package:movies_app/pages/about/about_page.dart';
import 'package:movies_app/pages/home/home_page.dart';
import 'package:movies_app/pages/now_playing/now_playing_page.dart';
import 'package:movies_app/pages/top_rated/top_rated_page.dart';
import 'package:movies_app/pages/upcoming/upcoming_page.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    color: Colors.blue,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                AssetImage('assets/images/shape.jpg'),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Nevin Trian",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
            title: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.play_circle_outline),
            onTap: () {
              Navigator.pushReplacementNamed(context, NowPlayingPage.routeName);
            },
            title: const Text(
              'Now Playing',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            onTap: () {
              Navigator.pushReplacementNamed(context, TopRatedPage.routeName);
            },
            title: const Text(
              'Top Rated',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.live_tv),
            onTap: () {
              Navigator.pushReplacementNamed(context, UpcomingPage.routeName);
            },
            title: const Text(
              'Upcoming',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.more_horiz),
            onTap: () {
              Navigator.pushReplacementNamed(context, AboutPage.routeName);
            },
            title: const Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
