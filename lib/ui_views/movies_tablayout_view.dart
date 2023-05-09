import 'package:flutter/material.dart';

import 'top_rated_movies_view.dart';

class MoviesTablayoutView extends StatefulWidget {
  final TabController? tabController;

  const MoviesTablayoutView({super.key, required this.tabController});

  @override
  State<StatefulWidget> createState() => _MoviesTablayoutState();
}

class _MoviesTablayoutState extends State<MoviesTablayoutView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: TabBarView(
        controller: widget.tabController,
        children: const <Widget>[
          TopShowingMovies(),
          TopShowingMovies(),
          TopShowingMovies(),
          TopShowingMovies(),
        ],
      ),
    );
  }
}
