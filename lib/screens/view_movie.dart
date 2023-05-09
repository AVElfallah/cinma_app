import 'package:cinma_app/controllers/view_movie_controller.dart';
import 'package:cinma_app/models/results.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/urls.dart';
import '../constants/constants.dart';
import '../styles/cinema_theme.dart';
import '../ui_views/bottom_sheet_view.dart';

class ViewMovieScreen extends StatefulWidget {
  const ViewMovieScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ViewMovieScreenState();
}

class _ViewMovieScreenState extends State<ViewMovieScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    Results? results = args['results'];

    return ChangeNotifierProvider<ViewMovieController>(
        create: (context) => ViewMovieController(results!),
        builder: (context, _) {
          var watch = context.watch<ViewMovieController>();
          var read = context.read<ViewMovieController>();
          return Scaffold(
            backgroundColor: CinemaAppTheme.background,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "${Urls.image_base_url}${results!.backdrop_path}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                gradientShadow(),
                                Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.3,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 30.0,
                                        right: 30.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                results.title ??
                                                    results.name ??
                                                    '',
                                                style: const TextStyle(
                                                    fontFamily:
                                                        Constants.POPPINS,
                                                    fontSize: 20.0,
                                                    height: 0.9,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                results.name ??
                                                    results.media_type!,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        Constants.POPPINS,
                                                    fontSize: 14.0,
                                                    height: 0.9,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                "${results.overview}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                        Constants.OPEN_SANS,
                                                    fontSize: 13.0),
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SafeArea(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SafeArea(
                          child: IconButton(
                            onPressed: () {
                              read.changeSaveState(results);
                            },
                            icon: Icon(
                              Icons.bookmark,
                              color: watch.isSaved ? Colors.red : Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => TicketBookingBottomSheet(
                            movie: results,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 50),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text("Book Now"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget gradientShadow() => Container(
        decoration: const BoxDecoration(
          color: CinemaAppTheme.background,
          borderRadius: BorderRadius.all(
            Radius.circular(
              0.0,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              CinemaAppTheme.background,
              Colors.transparent,
            ],
          ),
        ),
      );
}
