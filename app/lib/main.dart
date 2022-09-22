// ignore: unused_import
import 'dart:async';
import 'package:app/farmer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSample();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.4279633588664, -122.885749655962),
    zoom: 14.4746,
  );
  Static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792)
  );
}
void _onMapCreated(GoogleMapControlle controller){
  _controller.complete(controller);


@override
Widget build(BuildContext context){
  return MaterialApp(
    home: Scaffold(
      body: Stack(

        children:<Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            
            myLocationButtonEnabled:false
          ),
          Container(
            padding: EdgeInsets.only(top:500, bottom: 50),
            child:ListView(
              padding: EdgeInsets.only(left: 40),
              scrollDirection: Axis.horizontal,
              children: getTechniciansInArea(),
            ),
          ),
        ],
      )
    ),
  );
}
List<Widget>getTechniciansInArea(){
  return[
    Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      color: Colors.white,
    ),
  ];
}
List<Widget> getTechniciansInArea(){
  return[
    
    technicianCard( technician)
  ];
}
Widget technicianCard(Technician technician){
    return Container(
      margin: EdgeInsets.all(Radius.circular(20)),
      width: 180,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
        new BoxShadow(
          color:Colors.grey,
          blurRadius: 20.0
        ),
      ],
        
      ),
      
    );
    
  }
  
 Container(
    margin: EdgeInsets.only(right: 20),
    width: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
 ),
 Container(
  margin:EdgeInsets.only(right: 20),
  width:200,
  decoration =BoxDecoration(
    borderRadius:BorderRadius.all(Radius.circular(20)),
    color: Colors.white, 
  ),
),