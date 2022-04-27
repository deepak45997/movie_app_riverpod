import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/Models/now_playing.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';

// ignore: non_constant_identifier_names, avoid_types_as_parameter_names
final nowplayingmoviesdata = FutureProvider<List<Result>>((Ref) async {
  final response =
      await http.get(Uri.parse(Appassets.nowplaying + Appassets.apiKey));
  // ignore: unrelated_type_equality_checks
  if (response == 200) {
    print("connection successful");
  } else {
    print("Something went wrong");
  }

  return Welcome.fromJson(jsonDecode(response.body)).results;
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
