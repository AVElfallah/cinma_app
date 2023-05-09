import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cinma_app/api/urls.dart';

import '../models/results.dart';
import '../models/trend.dart';

class Services {
  static Future<Trend?> getTrendingMovies() async {
    try {
      final response = await http.get(Uri.parse(Urls.trending_movies_url));
      if (isResponceOk(response)) {
        return parseTrendingMovies(response.body);
      }
      return Trend();
    } catch (e) {
      return Trend();
    }
  }

  static Trend? parseTrendingMovies(String responseBody) {
    try {
      var jsonMap = (jsonDecode(responseBody)['results']);

      List<Results> movies =
          jsonMap.map<Results>((js) => Results.fromJson(js)).toList();

      Trend t = Trend(results: movies);
      return t;
    } catch (e) {
      return null;
    }
  }

  static bool isResponceOk(http.Response response) {
    if (200 != response.statusCode) {
      return false;
    }
    return true;
  }
}
