import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/TV_Model/popular_tvshow_model.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';

// ignore: non_constant_identifier_names, avoid_types_as_parameter_names
final populartvshowProvider = FutureProvider<List<Result>>((Ref) async {
  final response =
      await http.get(Uri.parse(Appassets.populartvshow + Appassets.apiKey));

  if (response.statusCode == 200) {
    print("Response is successful for populartvshow");
  } else {
    print("Something is wrong in populartvshow");
  }
  return Populartvshow.fromJson(jsonDecode(response.body)).results;
});
