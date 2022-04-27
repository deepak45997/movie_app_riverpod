import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/AppSize/appSize.dart';
import 'package:movie_app_riverpod/MovieDetail/trending_movies_detail.dart';
import 'package:movie_app_riverpod/Route/app_route.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';
import 'package:movie_app_riverpod/Widgets/textWidget.dart';
import 'package:movie_app_riverpod/movie_controller/trending_movies_ctrl.dart';

class TrendingMoviePage extends StatelessWidget {
  const TrendingMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("Trending movies"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          final trendingdata = ref.watch(trendingProvider);
          return trendingdata.when(
              data: (data) => GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: (2 / 5),
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        AppRoute.navigateTo(
                            context,
                            TrendingDetail(
                                id: data[index].id,
                                imagepath: Appassets.imagepath,
                                posterPath: data[index].posterPath.toString(),
                                backposter: data[index].backdropPath.toString(),
                                movie_name: data[index].name.toString(),
                                rating: data[index].voteAverage as double,
                                overview: data[index].overview.toString()));
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "${Appassets.imagepath}${data[index].posterPath}",
                              height: AppSize().height(context) * 0.3,
                              fit: BoxFit.fill,
                            ),
                            data[index].title == null
                                ? Container()
                                : Text(
                                    "${data[index].title}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ],
                        ),
                      ),
                    );
                  }),
              error: (e, st) => Text("Error is= $st"),
              loading: () => const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
