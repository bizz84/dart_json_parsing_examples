import 'dart:convert';

class Restaurant {
  Restaurant({required this.name, required this.cuisine, this.yearOpened});
  final String name;
  final String cuisine;
  final int? yearOpened;

  factory Restaurant.fromJson(Map<String, dynamic> data) {
    final name = data['name'];
    if (name is! String) {
      // will throw if name is missing or not a String
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $data');
    }
    final cuisine = data['cuisine'];
    if (cuisine is! String) {
      // will throw if cuisine is missing or not a String
      throw FormatException(
          'Invalid JSON: required "cuisine" field of type String in $data');
    }
    // will throw if the value is neither null or an int
    final yearOpened = data['year_opened'] as int?;
    // name and cuisine are guaranteed to be non-null if we reach this line
    return Restaurant(name: name, cuisine: cuisine, yearOpened: yearOpened);
  }

  Map<String, dynamic> toJson() {
    // return a map literal with all the non-null key-value pairs
    return {
      'name': name,
      'cuisine': cuisine,
      // here we use collection-if to account for null values
      if (yearOpened != null) 'year_opened': yearOpened,
    };
  }

  @override
  String toString() =>
      'Restaurant(name: $name, cuisine: $cuisine, yearOpened: $yearOpened)';
}

void main() {
  // type: String
  final jsonData = '{ "name": "Pizza da Mario", "cuisine": "Italian" }';
  // type: dynamic (runtime type: _InternalLinkedHashMap<String, dynamic>)
  final parsedJson = jsonDecode(jsonData) as Map<String, dynamic>;
  // type: Restaurant
  final restaurant = Restaurant.fromJson(parsedJson);
  print(restaurant);

  // given a Restaurant object
  final restaurant2 = Restaurant(name: "Patatas Bravas", cuisine: "Spanish");
  // convert it to map
  final jsonMap = restaurant2.toJson();
  // encode it to a JSON string
  final encodedJson = jsonEncode(jsonMap);
  // then send it as a request body with any networking package
  print(encodedJson);
}
