// ignore: non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/Models/movie_cast_model.dart';
import 'package:movie_app_riverpod/Models/upcoming.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';

final upcoming = FutureProvider<List<Result>>((Ref) async {
  final response =
      await http.get(Uri.parse(Appassets.upcoming + Appassets.apiKey));

  if (response.statusCode == 200) {
    print("Connection is done for upcoming movies");
  } else {
    print("Something is wrong in upcoming movies");
  }
  try {
    return Welcomee.fromJson(jsonDecode(response.body)).results;
  } on Exception catch (e) {
    print(e);

    return [];
  }

  // return Welcomee.fromJson(jsonDecode(response.body)).results;
});

// ignore: avoid_types_as_parameter_names, non_constant_identifier_names
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

class Upcomingcastview extends StateNotifier<int> {
  Upcomingcastview() : super(0);

  addid(id) {
    state = id;

    print("s;dkkl;d");
  }
}

final upcomijngcastProvider =
    StateNotifierProvider<Upcomingcastview, int>((ref) {
  return Upcomingcastview();
});

// ignore: non_constant_identifier_names
final upcomingprofileapi = FutureProvider<List<Cast>>((ref) async {
  final imageid = ref.watch(upcomijngcastProvider);

  print(imageid);
  String url =
      'https://api.themoviedb.org/3/movie/$imageid/credits?api_key=2554faa645300e4049d0e1aa9a11acc0';
  final response = await http.get(Uri.parse(url));
  // ignore: unrelated_type_equality_checks
  if (response.statusCode == 200) {
    print("Response successful for profilepic");
  } else {
    print("Something is wrong in profilepic");
  }

  try {
    return Weelcome.fromJson(jsonDecode(response.body)).cast;
  } on Exception catch (e) {
    print(e);

    return [];
  }
});
