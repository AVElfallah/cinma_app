// ignore_for_file: non_constant_identifier_names

class Results {
  final num? id;
  final bool? video;
  final num? vote_count;
  final num? vote_average;
  final String? name;
  final String? title;
  final String? release_date;
  final String? original_language;
  final String? original_title;
  final String? backdrop_path;
  final bool? adult;
  final String? overview;
  final String? poster_path;
  final num? popularity;
  final String? media_type;

  Results({
    this.id,
    this.video,
    this.vote_count,
    this.vote_average,
    this.name,
    this.title,
    this.release_date,
    this.original_language,
    this.original_title,
    this.backdrop_path,
    this.adult,
    this.overview,
    this.poster_path,
    this.popularity,
    this.media_type,
  });

  factory Results.fromJson(Map json) => Results(
        id: (json['id'] as num?) ?? 0,
        video: (json['video'] as bool?) ?? false,
        vote_count: json['vote_count'] as num?,
        vote_average: json['vote_average'] as num?,
        name: (json['name'] ?? '') as String?,
        title: json['title'] as String?,
        release_date: json['release_date'] as String?,
        original_language: json['original_language'] as String?,
        original_title: json['original_title'] as String?,
        backdrop_path: json['backdrop_path'] as String?,
        adult: json['adult'] as bool?,
        overview: json['overview'] as String?,
        poster_path: json['poster_path'] as String?,
        popularity: json['popularity'] as num?,
        media_type: json['media_type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'video': video,
        'vote_count': vote_count,
        'vote_average': vote_average,
        'name': name,
        'title': title,
        'release_date': release_date,
        'original_language': original_language,
        'original_title': original_title,
        'backdrop_path': backdrop_path,
        'adult': adult,
        'overview': overview,
        'poster_path': poster_path,
        'popularity': popularity,
        'media_type': media_type,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Results &&
        id == other.id &&
        video == other.video &&
        vote_count == other.vote_count &&
        vote_average == other.vote_average &&
        name == other.name &&
        title == other.title &&
        release_date == other.release_date &&
        original_language == other.original_language &&
        original_title == other.original_title &&
        backdrop_path == other.backdrop_path &&
        adult == other.adult &&
        overview == other.overview &&
        poster_path == other.poster_path &&
        popularity == other.popularity &&
        media_type == other.media_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        video.hashCode ^
        vote_count.hashCode ^
        vote_average.hashCode ^
        name.hashCode ^
        title.hashCode ^
        release_date.hashCode ^
        original_language.hashCode ^
        original_title.hashCode ^
        backdrop_path.hashCode ^
        adult.hashCode ^
        overview.hashCode ^
        poster_path.hashCode ^
        popularity.hashCode ^
        media_type.hashCode;
  }
}
