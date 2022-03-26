import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies_app/components/api_url.dart';

class DetailModel {
  Future<LinkedHashMap> get(String? id) async {
    var result = await http.get(
      Uri.parse(ApiUrl.url + "movie/$id" + ApiUrl.apiKey),
    );
    return json.decode(result.body);
  }
}
