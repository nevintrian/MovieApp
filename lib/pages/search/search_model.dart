import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies_app/components/api_url.dart';

class SearchModel {
  Future<List<dynamic>> get(String value) async {
    var result = await http.get(
      Uri.parse(ApiUrl.url + "search/movie/" + ApiUrl.apiKey + '&query=$value'),
    );
    return json.decode(result.body)['results'];
  }
}
