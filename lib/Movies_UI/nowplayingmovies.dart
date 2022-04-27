import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_riverpod/AppSize/appSize.dart';
import 'package:movie_app_riverpod/Route/app_route.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';
import 'package:movie_app_riverpod/Widgets/textWidget.dart';
import 'package:movie_app_riverpod/movie_controller/nowplaying_movies_ctrl.dart';

import '../MovieDetail/nowplaying_movie_detail.dart';

class NowPlaying extends StatelessWidget {
  NowPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget("Now Playing Movies"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          final apidata = ref.watch(nowplayingmoviesdata);
          return apidata.when(
              data: (apidata) => ListView.builder(
                  itemCount: apidata.length,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      width: AppSize().width(context),
                      height: AppSize().height(context) * 0.6,
                      child: InkWell(
                        onTap: () {
                          AppRoute.navigateTo(
                              context,
                              NowplayingDetail(
                                  id: apidata[index].id,
                                  imagepath: Appassets.imagepath,
                                  posterPath: apidata[index].posterPath,
                                  backposter: apidata[index].backdropPath,
                                  movie_name: apidata[index].title,
                                  rating: apidata[index].voteAverage,
                                  overview: apidata[index].overview));
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                "${Appassets.imagepath}${apidata[index].posterPath}",
                                height: AppSize().height(context) * 0.45,
                                width: AppSize().width(context),
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: AppSize().height(context) * 0.03,
                              ),
                              Text(
                                "${apidata[index].title}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: AppSize().height(context) * 0.01,
                              ),
                              Text(DateFormat.yMMMMd()
                                  .format(apidata[index].releaseDate))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              error: (e, st) => Text("Errordddd is=$e"),
              loading: () => const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
