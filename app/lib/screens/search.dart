import 'package:app/service/geolocator_service.dart';
import 'package:app/service/marker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/place.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      initialData: const [],
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  // ignore: unnecessary_null_comparison
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : <Marker>[];
                  // ignore: unnecessary_null_comparison
                  return (places != null)
                      ? Column(children: <Widget>[
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(currentPosition.latitude,
                                        currentPosition.longitude),
                                    zoom: 16.0),
                                zoomGesturesEnabled: true,
                                markers: Set<Marker>.of(markers),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: places.length,
                                itemBuilder: (context, index) {
                                  return FutureProvider(
                                    create: (context) => geoService.getDistance(
                                        currentPosition.latitude,
                                        currentPosition.longitude,
                                        places[index].geometry.location.lat,
                                        places[index].geometry.location.lng),
                                    initialData: null,
                                    child: Card(
                                      child: ListTile(
                                        title: Text(places[index].name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 3.0,
                                            ),
                                            // ignore: unnecessary_null_comparison
                                            (places[index].rating != null)
                                                ? Row(
                                                    children: <Widget>[
                                                      RatingBarIndicator(
                                                        rating: places[index]
                                                            .rating,
                                                        itemBuilder: (context,
                                                                index) =>
                                                            const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber),
                                                        itemCount: 5,
                                                        itemSize: 10,
                                                        direction:
                                                            Axis.horizontal,
                                                      )
                                                    ],
                                                  )
                                                : Row(),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Consumer<double>(
                                              builder:
                                                  (context, meters, Widget) {
                                                // ignore: unnecessary_null_comparison
                                                return (meters != null)
                                                    ? Text(
                                                        '${places[index].vicinity} \u00b7 ${(meters / 1609).round()}mi')
                                                    : Container();
                                              },
                                            )
                                          ],
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.directions),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            _launchMapUrl(
                                                places[index]
                                                    .geometry
                                                    .location
                                                    .lat,
                                                places[index]
                                                    .geometry
                                                    .location
                                                    .lng);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ])
                      : const Center(child: CircularProgressIndicator());
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void _launchMapUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'couldnot launch$url';
    }
  }
}
