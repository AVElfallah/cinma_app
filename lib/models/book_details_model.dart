// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cinma_app/models/results.dart';

class BookDetailsModel {
  DateTime? date;
  DateTime? time;
  Results? movie;
  BookDetailsModel({
    this.date,
    this.time,
    this.movie,
  });

  BookDetailsModel copyWith({
    DateTime? date,
    DateTime? time,
    Results? movie,
  }) {
    return BookDetailsModel(
      date: date ?? this.date,
      time: time ?? this.time,
      movie: movie ?? this.movie,
    );
  }

  @override
  bool operator ==(covariant BookDetailsModel other) {
    if (identical(this, other)) return true;

    return other.date == date && other.time == time && other.movie == movie;
  }

  @override
  int get hashCode => date.hashCode ^ time.hashCode ^ movie.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date?.millisecondsSinceEpoch,
      'time': time?.millisecondsSinceEpoch,
      'movie': movie?.toJson(),
    };
  }

  factory BookDetailsModel.fromMap(Map<String, dynamic> map) {
    return BookDetailsModel(
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'] as int)
          : null,
      movie: map['movie'] != null
          ? Results.fromJson(map['movie'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookDetailsModel.fromJson(String source) =>
      BookDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BookDetailsModel(date: $date, time: $time, movie: $movie)';
}
