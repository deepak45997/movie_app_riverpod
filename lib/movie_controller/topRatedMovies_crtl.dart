import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/Models/movie_cast_model.dart';
import 'package:movie_app_riverpod/Models/top_rated.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';

final loaderPoviderr = StateNotifierProvider<Lodr, bool>((ref) {
  return Lodr();
});

class Lodr extends StateNotifier<bool> {
  Lodr() : super(true);
}

/// TopRated movies
final topratedmoviesdata = FutureProvider<List<Result>>((ref) async {
  final response =
      await http.get(Uri.parse(Appassets.toprated + Appassets.apiKey));
  ref.watch(loaderPoviderr.notifier).state = false;
  // ignore: unrelated_type_equality_checks
  if (response == 200) {
    print("connection successful");
  } else {
    print("Something went wrong");
  }

  return Welcome.fromJson(jsonDecode(response.body)).results;
});

class Clock extends StateNotifier<String> {
  // 1. initialize with current time
  Clock()
      : super(
            "https://image.tmdb.org/t/p/w500/2CAL2433ZeIihfX1Hb2139CX0pW.jpg"); // https://image.tmdb.org/t/p/w500

  addimage(String image) {
    // ignore: void_checks
    state = image;
  }
}

final loderr = StateProvider<bool>((ref) {
  return false;
});

final clockProvider = StateNotifierProvider<Clock, String>((ref) {
  return Clock(); // https://image.tmdb.org/t/p/w500
});

class Titlle extends StateNotifier<String> {
  // 1. initialize with current time
  Titlle()
      : super(
            "Dilwale Dulhaniya le jayenge"); // https://image.tmdb.org/t/p/w500

  addtitle(String overview) {
    state = overview;
  }
}

final titleProvider = StateNotifierProvider<Titlle, String>((ref) {
  return Titlle(); // https://image.tmdb.org/t/p/w500
});

class Overview extends StateNotifier<String> {
  // 1. initialize with current time
  Overview()
      : super(
            "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga."); // https://image.tmdb.org/t/p/w500

  addoverview(String image) {
    // ignore: void_checks
    state = image;
  }
}

final overviewProvider = StateNotifierProvider<Overview, String>((ref) {
  return Overview(); // https://image.tmdb.org/t/p/w500
});

class Castview extends StateNotifier<int> {
  Castview() : super(19404);

  addid(id) {
    state = id;

    print("s;dkkl;d");
  }
}

final castProvider = StateNotifierProvider<Castview, int>((ref) {
  return Castview();
});

// ignore: non_constant_identifier_names
final profileapi = FutureProvider<List<Cast>>((ref) async {
  final imageid = ref.watch(castProvider);

  print(imageid);
  String url =
      'https://api.themoviedb.org/3/movie/$imageid/credits?api_key=2554faa645300e4049d0e1aa9a11acc0';
  final response = await http.get(Uri.parse(url));

  // ignore: unrelated_type_equality_check
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
