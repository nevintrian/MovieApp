import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies_app/components/api_url.dart';

class UpcomingModel {
  Future<List<dynamic>> get() async {
    var result = await http.get(
      Uri.parse(ApiUrl.url + "movie/upcoming" + ApiUrl.apiKey),
    );
    return json.decode(result.body)['results'];
  }
}
