import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/pages/about/about_page.dart';
import 'package:movies_app/pages/detail/detail_page.dart';
import 'package:movies_app/pages/home/home_page.dart';
import 'package:movies_app/pages/now_playing/now_playing_page.dart';
import 'package:movies_app/pages/search/search_page.dart';
import 'package:movies_app/pages/top_rated/top_rated_page.dart';
import 'package:movies_app/pages/upcoming/upcoming_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: _getRoute,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        AboutPage.routeName: (context) => const AboutPage(),
        NowPlayingPage.routeName: (context) => const NowPlayingPage(),
        TopRatedPage.routeName: (context) => const TopRatedPage(),
        UpcomingPage.routeName: (context) => const UpcomingPage(),
        // DetailPage.routeName: (context) => const DetailPage(),
        SearchPage.routeName: (context) => const SearchPage()
      },
    );
  }
}

Route<dynamic>? _getRoute(RouteSettings settings) {
  if (settings.name == DetailPage.routeName) {
    return _buildRoute(settings, DetailPage(settings.arguments));
  }

  return null;
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(
    settings: settings,
    builder: (ctx) => builder,
  );
}
