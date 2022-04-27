import 'dart:convert';

import 'package:http/http.dart' as http;

class Servicess {
  static Future<dynamic> fetchapidataa(String url) async {
    return await http
        .get(Uri.parse(url))
        .then((response) =>
            response.statusCode == 200 ? jsonDecode(response.body) : null)
        .catchError((err) => print(err));
  }
}
