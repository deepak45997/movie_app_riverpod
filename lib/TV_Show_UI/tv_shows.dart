import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/Route/app_route.dart';
import 'package:movie_app_riverpod/TV_Show_UI/tvshow_detail.dart';
import 'package:movie_app_riverpod/TV_show_controller/popular_tvshow_ctrl.dart';
import 'package:movie_app_riverpod/TV_show_controller/toprated_tvshow_ctrl.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';
import 'package:movie_app_riverpod/Widgets/textWidget.dart';

class TvshowsPage extends StatelessWidget {
  const TvshowsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("TV Shows"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Popular TV Show",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Consumer(builder: (_, WidgetRef ref, __) {
            final apidata = ref.watch(populartvshowProvider);
            return apidata.when(
                data: (data) => SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () {
                                AppRoute.navigateTo(
                                    context,
                                    TvshowDetail(
                                        id: data[index].id,
                                        imagepath: Appassets.imagepath,
                                        posterPath:
                                            data[index].posterPath.toString(),
                                        backposter:
                                            data[index].backdropPath.toString(),
                                        movie_name: data[index].name.toString(),
                                        rating:
                                            data[index].voteAverage as double,
                                        overview:
                                            data[index].overview.toString()));
                              },
                              child: Card(
                                  child: Column(
                                children: [
                                  Image.network(
                                    "${Appassets.imagepath}${data[index].posterPath}",
                                    height: 150,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              )),
                            );
                          }),
                    ),
                error: (e, st) => Text("Error is = $e"),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
          }),
          const Text(
            "Toprated TV Show",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Consumer(builder: (_, WidgetRef ref, __) {
            final apidata = ref.watch(topratedtvshowProvider);
            return apidata.when(
                data: (data) => SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () {
                                AppRoute.navigateTo(
                                    context,
                                    TvshowDetail(
                                        id: data[index].id,
                                        imagepath: Appassets.imagepath,
                                        posterPath:
                                            data[index].posterPath.toString(),
                                        backposter:
                                            data[index].backdropPath.toString(),
                                        movie_name: data[index].name.toString(),
                                        rating:
                                            data[index].voteAverage as double,
                                        overview:
                                            data[index].overview.toString()));
                              },
                              child: Card(
                                  child: Column(
                                children: [
                                  Image.network(
                                    "${Appassets.imagepath}${data[index].posterPath}",
                                    height: 150,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              )),
                            );
                          }),
                    ),
                error: (e, st) => Text("Error is = $e"),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
          }),
          const Text(
            "Popular TV Show",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Consumer(builder: (_, WidgetRef ref, __) {
            final apidata = ref.watch(populartvshowProvider);
            return apidata.when(
                data: (data) => SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () {
                                AppRoute.navigateTo(
                                    context,
                                    TvshowDetail(
                                        id: data[index].id,
                                        imagepath: Appassets.imagepath,
                                        posterPath:
                                            data[index].posterPath.toString(),
                                        backposter:
                                            data[index].backdropPath.toString(),
                                        movie_name: data[index].name.toString(),
                                        rating: data[index].voteAverage,
                                        overview:
                                            data[index].overview.toString()));
                              },
                              child: Card(
                                  child: Column(
                                children: [
                                  Image.network(
                                    "${Appassets.imagepath}${data[index].posterPath}",
                                    height: 150,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              )),
                            );
                          }),
                    ),
                error: (e, st) => Text("Error is = $st"),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
          }),
        ],
      ),
    );
  }
}
