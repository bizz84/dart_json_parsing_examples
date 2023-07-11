import 'dart:convert';

import 'package:equatable/equatable.dart';

class Review extends Equatable {
  Review({required this.score, this.review});
  // non-nullable - assuming the score field is always present
  final double score;
  // nullable - assuming the review field is optional
  final String? review;

  factory Review.fromJson(Map<String, dynamic> data) {
    final score = data['score'];
    if (score is! double) {
      throw FormatException(
          'Invalid JSON: required "score" field of type double in $data');
    }
    final review = data['review'] as String?;
    return Review(score: score, review: review);
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      // here we use collection-if to account for null values
      if (review != null) 'review': review,
    };
  }

  @override
  List<Object?> get props => [score, review];

  @override
  bool? get stringify => true;
}

class Restaurant extends Equatable {
  Restaurant({
    required this.name,
    required this.cuisine,
    this.yearOpened,
    required this.reviews,
  });
  final String name;
  final String cuisine;
  final int? yearOpened;
  final List<Review> reviews;

  factory Restaurant.fromJson(Map<String, dynamic> data) {
    final name = data['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $data');
    }
    final cuisine = data['cuisine'];
    if (cuisine is! String) {
      throw FormatException(
          'Invalid JSON: required "cuisine" field of type String in $data');
    }
    final yearOpened = data['year_opened'] as int?;
    final reviewsData = data['reviews'] as List<dynamic>?;
    return Restaurant(
      name: name,
      cuisine: cuisine,
      yearOpened: yearOpened,
      reviews: reviewsData != null
          ? reviewsData
              // map each review to a Review object
              .map((reviewData) =>
                  Review.fromJson(reviewData as Map<String, dynamic>))
              .toList() // map() returns an Iterable so we convert it to a List
          : <Review>[], // use an empty list as fallback value
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cuisine': cuisine,
      if (yearOpened != null) 'year_opened': yearOpened,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [name, cuisine, yearOpened, reviews];

  @override
  bool? get stringify => true;
}

void main() {
  final jsonData = '''
{
  "name": "Pizza da Mario",
  "cuisine": "Italian",
  "reviews": [
    {
      "score": 4.5,
      "review": "The pizza was amazing!" 
    },
    {
      "score": 5.0,
      "review": "Very friendly staff, excellent service!"
    }
  ]
}
''';
  final json = jsonDecode(jsonData) as Map<String, dynamic>;
  // final json = {
  //   "name": "Ezo Sushi",
  //   "cuisine": "Japanese",
  //   "reviews": [
  //     {"score": 4.5, "review": "The pizza was amazing!"},
  //     {"score": 5.0, "review": "Very friendly staff, excellent service!"}
  //   ]
  // };
  final restaurant = Restaurant.fromJson(json);
  print(restaurant);

  // final restaurant = Restaurant(
  //   name: 'Pizza da Mario',
  //   cuisine: 'Italian',
  //   reviews: [
  //     Review(score: 4.5, review: 'The pizza was amazing!'),
  //     Review(score: 5.0, review: 'Very friendly staff, excellent service!'),
  //   ],
  // );
  // final encoded = jsonEncode(restaurant.toJson());
  // print(encoded);
}
