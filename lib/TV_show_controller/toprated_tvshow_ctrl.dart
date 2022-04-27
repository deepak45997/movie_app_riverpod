import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/TV_Model/toprated_tvshow_model.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';

// ignore: non_constant_identifier_names, avoid_types_as_parameter_names
final topratedtvshowProvider = FutureProvider<List<Result>>((Ref) async {
  final response =
      await http.get(Uri.parse(Appassets.topratedtvshow + Appassets.apiKey));

  if (response.statusCode == 200) {
    print("Response is successful for populartvshow");
  } else {
    print("Something is wrong in populartvshow");
  }
  return Topratedtvshow.fromJson(jsonDecode(response.body)).results;
});
