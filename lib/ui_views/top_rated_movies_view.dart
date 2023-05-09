import 'package:cinma_app/router/router.dart';
import 'package:flutter/material.dart';

import '../api/services.dart';
import '../api/urls.dart';
import '../constants/constants.dart';
import '../models/trend.dart';
import '../screens/view_movie.dart';
import '../styles/cinema_theme.dart';

class TopShowingMovies extends StatefulWidget {
  const TopShowingMovies({super.key});

  @override
  State<StatefulWidget> createState() => _TopShowingMoviesState();
}

class _TopShowingMoviesState extends State<TopShowingMovies>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<TopShowingMovies> {
  Trend? _trend;

  @override
  void initState() {
    super.initState();
    Services.getTrendingMovies().then((trendsFromServer) {
      setState(() {
        _trend = trendsFromServer;
      });
    });
  }

  late AnimationController animationController;
  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: const BoxDecoration(
        color: CinemaAppTheme.background,
      ),
      height: MediaQuery.of(context).size.height *
          0.55, // <------------------  card height
      width: double.infinity,
      child: trendsListView(),
    );
  }

  Widget trendsListView() => ListView.builder(
        addAutomaticKeepAlives: true,
        padding: const EdgeInsets.only(
          bottom: 0,
          right: 17,
          left: 0,
        ),
        itemCount: (_trend?.results?.length) ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
              color: CinemaAppTheme.background,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: Material(
              child: InkWell(
                splashColor: CinemaAppTheme.background,
                onTap: () {
                  //TODO -  navigate to movie details screen
                  Navigator.of(context)
                      .pushNamed(AppRouter.viewMovie, arguments: {
                    'results': _trend!.results![index],
                  });
                },
                child: Container(
                  decoration:
                      const BoxDecoration(color: CinemaAppTheme.background),
                  width: MediaQuery.of(context).size.width *
                      0.37, // <------------------  card widgth
                  child: showAllUI(index),
                ),
              ),
            ),
          );
        },
      );

  Widget showAllUI(int index) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            margin: const EdgeInsets.only(right: 7.0),
            decoration: BoxDecoration(
              color: CinemaAppTheme.background,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CinemaAppTheme.background.withOpacity(
                    0.2,
                  ),
                  offset: const Offset(
                    1.1,
                    4.0,
                  ),
                  blurRadius: 8.0,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(
                  _trend!.results![index].poster_path == null
                      ? ""
                      : "${Urls.image_base_url}${_trend!.results![index].poster_path}",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: Text(
              _trend!.results![index].title ??
                  _trend!.results![index].name ??
                  '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: Constants.POPPINS,
                fontSize: 14.5,
                height: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text(
            "3D, iMAX, Cinema",
            maxLines: 1,
            style: TextStyle(
              fontFamily: Constants.POPPINS,
              color: CinemaAppTheme.background,
              fontSize: 9.0,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );

  @override
  bool get wantKeepAlive => true;
}
