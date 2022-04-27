import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/AppSize/appSize.dart';
import 'package:movie_app_riverpod/Utils/appAssets.dart';
import 'package:movie_app_riverpod/Widgets/textWidget.dart';
import 'package:movie_app_riverpod/movie_controller/upcomingMovie_ctrl.dart';

class TvshowDetail extends StatelessWidget {
  TvshowDetail(
      // ignore: non_constant_identifier_names
      {Key? key,
      required this.id,
      required this.imagepath,
      required this.posterPath,
      required this.backposter,
      required this.movie_name,
      required this.rating,
      required this.overview})
      : super(key: key);

  final id;
  final String imagepath;
  final String posterPath;
  final String backposter;
  final String movie_name;
  final String overview;
  final double rating;

  bool cast = true;

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
        appBar: AppBar(
          title: const TextWidget(
            "Upcoming Movies Detail",
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Container(
              width: AppSize().width(context),
              height: AppSize().height(context) * 0.32,
              child: Stack(
                children: [
                  // ignore: unnecessary_null_comparison
                  if (backposter != null && backposter.isNotEmpty == true)
                    Image.network(
                      "${Appassets.imagepath}$backposter",
                      color: const Color.fromRGBO(100, 49, 44, 0.8),
                      colorBlendMode: BlendMode.modulate,
                    )
                  else
                    Container(
                      width: AppSize().width(context),
                      height: AppSize().height(context) * 0.3,
                      color: Colors.grey,
                    ),

                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: AppSize().width(context) * 0.4,
                              height: AppSize().height(context) * 0.5,
                              child: Image.network(
                                "${Appassets.imagepath}${posterPath}",
                              ),
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: AppSize().height(context) * 0.04),
                            child: Text(
                              movie_name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "Rating =$rating",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const Text(
                            "OverView",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                width: AppSize().width(context) * 0.55,
                                //  height: AppSize().height(context) * 0.14,
                                child: Text(
                                  '$overview $overview $overview $overview',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 11.0, left: 10),
                  child: Consumer(builder: (_, WidgetRef ref, __) {
                    final castorcrew = ref.watch(movie_member);
                    return Text(
                      cast == false ? "Movie Cast" : "Movie Crew",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: AppSize().height(context) * 0.045,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey),
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final castorcreww = ref.watch(movie_member);
                        return PopupMenuButton(
                          icon: const Center(
                              child: Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          )),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                value: 1,
                                child: Text("Cast Detail"),
                                onTap: () {
                                  ref.read(movie_member).cast();
                                  ref
                                      .read(upcomijngcastProvider.notifier)
                                      .addid(id);
                                },
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text("Crew Detail"),
                                onTap: () {
                                  cast = true;
                                  ref.read(movie_member).crew();
                                },
                              ),
                            ];
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Consumer(builder: (_, WidgetRef ref, __) {
              final profiledataAsyncValue = ref.watch(upcomingprofileapi);
              return profiledataAsyncValue.when(
                  data: (data) => SizedBox(
                        height: AppSize().height(context) * 0.42,
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
                                          height: 250,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        ),
                                        data[index].originalName == null
                                            ? Container()
                                            : Text(
                                                "${data[index].originalName}",
                                                style: TextStyle(
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
        ));
  }
}
