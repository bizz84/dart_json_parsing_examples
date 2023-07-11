class Restaurant {
  Restaurant({required this.name, required this.cuisine, this.yearOpened});
  final String name;
  final String cuisine;
  final int? yearOpened;

  factory Restaurant.fromJson(Map<String, dynamic> data) {
    if (data
        case {
          'name': String name,
          'cuisine': String cuisine,
          'year_opened': int? yearOpened,
        }) {
      //final yearOpened = data['year_opened'] as int?;
      return Restaurant(name: name, cuisine: cuisine, yearOpened: yearOpened);
    } else {
      if (data['name'] is! String) {
        throw FormatException(
            'Invalid JSON: required "name" field of type String in $data');
      }
      if (data['cuisine'] is! String) {
        throw FormatException(
            'Invalid JSON: required "cuisine" field of type String in $data');
      }
      throw FormatException('Invalid JSON: $data');
    }
  }

  @override
  String toString() =>
      'Restaurant(name: $name, cuisine: $cuisine, yearOpened: $yearOpened)';
}

void main() {
  final json = {
    'name': 'Ezo Sushi',
    'cuisine': 'Japanese',
    'year_opened': null,
  };
  final restaurant = Restaurant.fromJson(json);
  print(restaurant);
}
