import 'dart:core';
import 'package:app/screens/search.dart';
import 'package:app/service/places_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/place.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:app/service/geolocator_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => locatorService.getLocation(),
          initialData: null,
        ),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return PlacesService()
                .getPlaces(position.latitude, position.longitude);
          },
        )
      ],
      child: MaterialApp(
        title: 'Fresh Foods',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Search(),
      ),
    );
  }
}
