import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapState();
  }
}

class MapState extends State<Map> {
  GoogleMapController mapController;
  CameraPosition _cameraPosition;
  double _latitude = 0;
  double _longitude = 0;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void _getLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((currentLocation) {
      setState(() {
        _cameraPosition = CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 10.0);
        _latitude = currentLocation.latitude;
        _longitude = currentLocation.longitude;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _latitude != 0 && _longitude != 0
          ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _cameraPosition,
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
