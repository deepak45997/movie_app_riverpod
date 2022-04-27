import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_riverpod/AppSize/appSize.dart';
import 'package:movie_app_riverpod/Loader/loader.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';
import 'package:movie_app_riverpod/Widgets/textWidget.dart';
import 'package:movie_app_riverpod/movie_controller/topRatedMovies_crtl.dart';

class TopRatedMovies extends StatefulWidget {
  TopRatedMovies({Key? key}) : super(key: key);

  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  bool poster = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("Top Rated Movies"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          final Clock member = ref.read(clockProvider.notifier);
          final Titlle title = ref.read(titleProvider.notifier);
          final Overview overview = ref.read(overviewProvider.notifier);
          final crewid = ref.read(castProvider.notifier);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(builder: (context, WidgetRef ref, child) {
                final moviesAsyncValue = ref.watch(topratedmoviesdata);
                return ref.watch(loaderPoviderr.notifier).state
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Loader())
                    : moviesAsyncValue.when(
                        data: (movies) => SizedBox(
                              height: AppSize().height(context) * 0.38,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movies.length,
                                itemBuilder: (ctx, index) {
                                  final movie = movies[index];
                                  return Container(
                                    width: AppSize().width(context) * 0.5,
                                    height: AppSize().height(context) * 0.8,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    child: Card(
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: AppSize().height(context) *
                                                0.45,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // ignore: invalid_use_of_protected_member
                                                    //    member.state = movie.posterPath;
                                                    member.addimage(
                                                        movie.posterPath);
                                                    title.addtitle(movie.title);
                                                    overview.addoverview(
                                                        movie.overview);
                                                    print(
                                                        "--------> id =${movie.id}");
                                                    crewid.addid(movie.id);
                                                    print("sdkflkdsjf");
                                                    poster = true;
                                                    // setState(() {});
                                                  },
                                                  child: Image.network(
                                                    '${Appassets.imagepath}${movie.posterPath}',
                                                    height: AppSize()
                                                            .height(context) *
                                                        0.2,
                                                    width: AppSize()
                                                        .width(context),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: AppSize()
                                                          .height(context) *
                                                      0.03,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    movie.title,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: AppSize()
                                                                .height(
                                                                    context) *
                                                            0.02),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: AppSize().height(context) * 0.03,
                                                // ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      DateFormat.yMMMMd()
                                                          .format(movie
                                                              .releaseDate)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              bottom:
                                                  AppSize().height(context) *
                                                      0.13,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.green,
                                                  child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: Text(
                                                      movie.voteAverage
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                              top: 2,
                                              right: 3,
                                              child: Container(
                                                height:
                                                    AppSize().height(context) *
                                                        0.045,
                                                decoration: BoxDecoration(
                                                    color: Colors.black26,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: PopupMenuButton(
                                                  icon: const Center(
                                                      child: Icon(
                                                    Icons.more_horiz,
                                                    color: Colors.white,
                                                  )),
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return [
                                                      const PopupMenuItem(
                                                          value: 1,
                                                          child: Text(
                                                              "Cast Detail")),
                                                      const PopupMenuItem(
                                                          child: Text(
                                                              "Crew Detail"))
                                                    ];
                                                  },
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        error: (e, st) => Text("Error is :$e"),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()));
              }),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(builder: (context, WidgetRef ref, child) {
                    final member2 = ref.watch(clockProvider);

                    print(">>>>>>${member2}");

                    return Image.network(
                      '${Appassets.imagepath}$member2',
                      fit: BoxFit.fill,
                      height: 160,
                      width: 160,
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Consumer(
                          builder: (_, WidgetRef ref, __) {
                            final title2 = ref.watch(titleProvider);
                            return SizedBox(
                              width: 200,
                              child: Text(
                                "$title2",
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(
                            "Overview",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Consumer(
                          builder: (_, WidgetRef ref, __) {
                            final overview2 = ref.watch(overviewProvider);
                            return SizedBox(
                              width: 200,
                              child: Text(
                                overview2,
                                maxLines: 6,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Text(
                "Movie cast and crew member",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Consumer(builder: (_, WidgetRef ref, __) {
                final profiledataAsyncValue = ref.watch(profileapi);
                return profiledataAsyncValue.when(
                    data: (data) => SizedBox(
                          height: AppSize().height(context) * 0.22,
                          child: ListView.builder(
                            itemCount: data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, index) {
                              return (data[index].profilePath == '')
                                  ? const SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Icon(
                                        Icons.person,
                                      ))
                                  : Card(
                                      child: Column(
                                        children: [
                                          Image.network(
                                            "${Appassets.imagepath}${data[index].profilePath}",
                                            height: 130,
                                            width: 100,
                                            fit: BoxFit.fill,
                                          ),
                                          data[index].originalName == null
                                              ? Container()
                                              : Text(
                                                  "${data[index].originalName}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                    error: (e, st) => Text("Error is=$st"),
                    loading: () => const CircularProgressIndicator());
              })
            ],
          );
        },
      ),
    );
  }
}
