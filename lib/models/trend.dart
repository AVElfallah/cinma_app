import "results.dart";

class Trend {
  Trend({
    this.page,
    this.results,
  });

  num? page;
  List<Results>? results;

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
      page: json['page'] as num,
      results: (json['results'] as List)
          .map(
            (e) => e == null
                ? null
                : Results.fromJson(
                    e as Map<String, dynamic>,
                  ),
          )
          .cast<Results>()
          .toList());

  Map<String, dynamic> toJson() => {
        'page': page,
        'results': results,
      };
}
