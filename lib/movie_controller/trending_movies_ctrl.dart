import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/Models/trendingmovies_model.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';

// ignore: non_constant_identifier_names, avoid_types_as_parameter_names
final trendingProvider = FutureProvider<List<Result>>((Ref) async {
  final response =
      await http.get(Uri.parse(Appassets.trending + Appassets.apiKey));

  if (response.statusCode == 200) {
    print("Respose is successful for trending");
  } else {
    print("Something is wrong in trending");
  }

  return Welcoome.fromJson(jsonDecode(response.body)).results;
});

final movie_member =
    ChangeNotifierProvider<MemberNotifier>((ref) => MemberNotifier());

class MemberNotifier extends ChangeNotifier {
  String member = "Movie Cast";

  void cast() {
    member = "Movie Cast";

    notifyListeners();
  }

  void crew() {
    member = "Movie Crew";
    notifyListeners();
  }
}
