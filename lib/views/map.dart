import 'dart:async';

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
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition;
  double _latitude = 0;
  double _longitude = 0;
  BitmapDescriptor _pinLocationIcon;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((currentLocation) {
      setState(() {
        _cameraPosition = CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 15.0);
        _latitude = currentLocation.latitude;
        _longitude = currentLocation.longitude;
      });
    });
  }

  void _setCustomMapPin() async {
    _pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/imgs/icon_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _latitude != 0 && _longitude != 0
          ? GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _setCustomMapPin();
                setState(() {
                  _markers.add(Marker(
                      markerId: MarkerId("Marker1"),
                      position: LatLng(_latitude, _longitude),
                      infoWindow: InfoWindow(
                          title: 'I am a marker',
                          onTap: () {
                            print('Clicado no infowindow');
                          }),
                      onTap: () {
                        print('Clicado no marker');
                      },
                      icon: _pinLocationIcon));
                });
              },
              markers: _markers,
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
