import 'dart:convert';

class Restaurant {
  Restaurant({required this.name, required this.cuisine, this.yearOpened});
  final String name;
  final String cuisine;
  final int? yearOpened;

  factory Restaurant.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final cuisine = data['cuisine'] as String;
    final yearOpened = data['year_opened'] as int?;
    return Restaurant(name: name, cuisine: cuisine, yearOpened: yearOpened);
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
}
