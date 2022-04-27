import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_riverpod/Movies_UI/popular_movies.dart';
import 'package:movie_app_riverpod/Movies_UI/topRatedMovies_page.dart';
import 'package:movie_app_riverpod/Movies_UI/trendingmovie_page.dart';
import 'package:movie_app_riverpod/Movies_UI/upcoming.dart';
import 'package:movie_app_riverpod/Route/app_route.dart';
import 'package:movie_app_riverpod/TV_Show_UI/tv_shows.dart';
import 'package:movie_app_riverpod/Widgets/textWidget.dart';

import 'nowplayingmovies.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("Entertainment"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Colors.black,
              child: const DrawerHeader(
                child: TextWidget(
                  "Movies and TV show",
                ),
              ),
            ),
            ExpansionTile(
              title: const TextWidget(
                "Movies",
              ),
              backgroundColor: Colors.black,
              children: [
                ListTile(
                    title: const TextWidget("Top Rated"),
                    onTap: () {
                      AppRoute.navigateTo(context, TopRatedMovies());
                    }),
                ListTile(
                  title: const TextWidget("Trending"),
                  onTap: () {
                    AppRoute.navigateTo(context, const TrendingMoviePage());
                  },
                ),
                ListTile(
                  title: const TextWidget("Upcoming"),
                  onTap: () {
                    AppRoute.navigateTo(context, const Upcomingmovies());
                  },
                ),
                ListTile(
                  title: TextWidget("Popular"),
                  onTap: () {
                    AppRoute.navigateTo(context, Popularmovies());
                  },
                ),
                ListTile(
                  title: TextWidget("Now Playing"),
                  onTap: () {
                    AppRoute.navigateTo(context, NowPlaying());
                  },
                )
              ],
            ),
            ListTile(
              title: const TextWidget(
                "TV show",
              ),
              onTap: () {
                AppRoute.navigateTo(context, TvshowsPage());
              },
            )
          ],
        ),
      ),
      body: const Center(
        child: Text("An Entertainment Application"),
      ),
    );
  }
}
// void navigateTo(BuildContext context, Widget page)
// {
//   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> page));
// }
