// https://raphaeldelio.medium.com/getting-started-with-flutter-map-9cf4113f22e9
// https://www.youtube.com/watch?v=YuwhlhaM1eM
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Geolocator Example'),
        ),
        body: Center(
          child: LocationWidget(),
        ),
      ),
    );
  }
}

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Future<void> _determinePosition() async {
    final permission = await Geolocator.checkPermission();
    final location = await Geolocator.getCurrentPosition();
    double distanceInMeters = Geolocator.distanceBetween(
        52.2165157, 6.9437819, 52.3546274, 4.8285838);
    print(location);
    print(distanceInMeters);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(51.509364, -0.128928),
              initialZoom: 10,
              //minZoom: 1,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              PolygonLayer(
                polygonCulling: false,
                polygons: [
                  Polygon(
                      points: [
                        LatLng(36.95, -9.5),
                        LatLng(42.25, -9.5),
                        LatLng(42.25, -6.2),
                        LatLng(36.95, -6.2),
                      ],
                      color: Colors.blue.withOpacity(0.5),
                      borderStrokeWidth: 2,
                      borderColor: Colors.blue,
                      isFilled: true),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      point: LatLng(51.509364, -0.128928),
                      width: 80,
                      height: 80,
                      child: Icon(Icons.person_pin_circle),
                      rotate: true),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
