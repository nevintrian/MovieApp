import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies_app/components/api_url.dart';

class TopRatedModel {
  Future<List<dynamic>> get() async {
    var result = await http.get(
      Uri.parse(ApiUrl.url + "movie/top_rated" + ApiUrl.apiKey),
    );
    return json.decode(result.body)['results'];
  }
}
