import 'package:flutter/material.dart';
import 'package:movies_app/components/drawer_component.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      drawer: const DrawerComponent(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [
              Text(
                "Movies App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text("API Source : www.themoviedb.org"),
              SizedBox(
                height: 10,
              ),
              Text("Created by : Nevin Trian")
            ],
          ),
        ),
      ),
    );
  }
}
