import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/AppSize/appSize.dart';
import 'package:movie_app_riverpod/MovieDetail/popular_movies_detail.dart';
import 'package:movie_app_riverpod/Route/app_route.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';
import 'package:movie_app_riverpod/Widgets/textWidget.dart';
import 'package:movie_app_riverpod/movie_controller/popular_movies_ctrl.dart';

class Popularmovies extends StatelessWidget {
  Popularmovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("Popular Movies"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          final apidata = ref.watch(popularmoviesdata);
          return apidata.when(
              data: (apidata) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (3 / 5),
                    ),
                    itemCount: apidata.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  AppRoute.navigateTo(
                                      context,
                                      PopularDetail(
                                          id: apidata[index].id,
                                          imagepath: Appassets.imagepath,
                                          posterPath: apidata[index].posterPath,
                                          backposter:
                                              apidata[index].backdropPath,
                                          movie_name: apidata[index].title,
                                          rating: apidata[index].voteAverage,
                                          overview: apidata[index].overview));
                                },
                                child: Container(
                                  height: AppSize().height(context) * 0.3,
                                  width: AppSize().height(context) * 0.2,
                                  child: Image.network(
                                    "${Appassets.imagepath}${apidata[index].posterPath}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                apidata[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${apidata[index].releaseDate}",
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              error: (e, st) => Text("Error is=$e"),
              loading: () => const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
