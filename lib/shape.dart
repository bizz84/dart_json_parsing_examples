import 'dart:math';

sealed class Shape {
  const Shape();
  double get area;

  factory Shape.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      // valid square
      {'type': 'square', 'side': double side} => Square(side),
      // invalid square
      {'type': 'square'} => throw FormatException(
          'Invalid JSON: required "side" field of type double in $json'),
      // valid circle
      {'type': 'circle', 'radius': double radius} => Circle(radius),
      // invalid circle
      {'type': 'circle'} => throw FormatException(
          'Invalid JSON: required "radius" field of type double in $json'),
      // invalid type
      {'type': String type} => throw FormatException(
          'Invalid JSON: shape $type is not recognized in $json'),
      // invalid JSON
      _ => throw FormatException('Invalid JSON: $json'),
    };
  }
}

class Square extends Shape {
  const Square(this.side);
  final double side;

  @override
  double get area => side * side;
}

class Circle extends Shape {
  const Circle(this.radius);
  final double radius;

  @override
  double get area => pi * radius * radius;
}

void printArea(Shape shape) {
  print(shape.area);
}

void main() {
  const shapesJson = [
    {
      'type': 'square',
      'side': 10.0,
    },
    {
      'type': 'circle',
      'radius': 5.0,
    },
  ];
  for (final json in shapesJson) {
    final shape = Shape.fromJson(json);
    print('${shape.runtimeType} area: ${shape.area}');
  }
}
