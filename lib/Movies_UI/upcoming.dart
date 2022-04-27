import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/MovieDetail/upcomingMovies_detail.dart';
import 'package:movie_app_riverpod/Route/app_route.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';
import 'package:movie_app_riverpod/Widgets/textWidget.dart';
import 'package:movie_app_riverpod/movie_controller/upcomingMovie_ctrl.dart';

class Upcomingmovies extends StatelessWidget {
  const Upcomingmovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextWidget("Upcoming Movies"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Consumer(
          builder: (_, WidgetRef ref, __) {
            final upcomingmoviesdataAsyncValue = ref.watch(upcoming);
            return upcomingmoviesdataAsyncValue.when(
                data: (upcoming) => ListView.builder(
                    itemCount: upcoming.length,
                    itemBuilder: (BuildContext context, index) {
                      final movieUpcoming = upcoming[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            AppRoute.navigateTo(
                                context,
                                UpcomingDetail(
                                    id: movieUpcoming.id,
                                    imagepath: Appassets.imagepath,
                                    posterPath: movieUpcoming.posterPath,
                                    backposter:
                                        movieUpcoming.backdropPath.toString(),
                                    movie_name: movieUpcoming.title,
                                    rating: movieUpcoming.voteAverage,
                                    overview: movieUpcoming.overview));
                          },
                          child: Image.network(
                              "${Appassets.imagepath}${movieUpcoming.posterPath}"),
                        ),
                      );
                    }),
                error: (e, st) => Text("Error is = $st"),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
          },
        ));
  }
}
