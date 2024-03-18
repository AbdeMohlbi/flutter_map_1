// https://raphaeldelio.medium.com/getting-started-with-flutter-map-9cf4113f22e9
// https://www.youtube.com/watch?v=YuwhlhaM1eM
// https://www.google.com/search?q=hide+the+navigation+bar+flutter&oq=hide+the+navigation+bar+flutter&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIICAEQABgWGB4yCAgCEAAYFhgeMggIAxAAGBYYHtIBCDk3MDJqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8#kpvalbx=_DDL4ZeWYM6OSkdUPtcC7iAU_24
// https://pub.dev/packages/flutter_map
// https://pub.dev/packages/geolocator
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'is_it_installed',
      theme: ThemeData(hintColor: Colors.yellow),
      home: const LocationWidget(),
    );
  }
}

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Marker m = Marker(
      point: LatLng(51.509364, -0.128928),
      width: 80,
      height: 80,
      child: Icon(Icons.add),
      rotate: true);

  List<Marker> mark_1 = [];
  void addMarker(LatLng position) {
    setState(() {
      mark_1.add(Marker(
        width: 40.0,
        height: 40.0,
        point: position,
        child: Icon(Icons.add),
      ));
    });
  }

  Future<void> _determinePosition() async {
    final permission = await Geolocator.checkPermission();
    final location = await Geolocator.getCurrentPosition();
    double distanceInMeters = Geolocator.distanceBetween(
        52.2165157, 6.9437819, 52.3546274, 4.8285838);
    print(location);
    print(distanceInMeters);
  }

  void abde(TapPosition a, LatLng b) {
    print(b.latitude);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );*/
    return SafeArea(
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(51.509364, -0.128928),
              initialZoom: 10,
              onTap: abde,
              //minZoom: 1,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              PolygonLayer(
                polygonCulling: false,
                polygons: [
                  Polygon(
                      points: [
                        LatLng(36.95, -9.5),
                        LatLng(42.25, -9.5),
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
                      child: Icon(Icons.add),
                      rotate: true),
                  Marker(
                      point: LatLng(50.509364, -0.128928),
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
