import 'package:app/models/location.dart';

class Geometry {
  final Location location;

  Geometry({required this.location});
  Geometry.fromJason(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJason(parsedJson['location']);

  static fromJson(parsedJson) {}
}
