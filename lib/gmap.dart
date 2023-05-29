import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GMap extends StatefulWidget {
  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = LinkedHashSet<Marker>();
  Set<Polygon> _polygons = LinkedHashSet<Polygon>();
  Set<Polyline> _polylines = LinkedHashSet<Polyline>();
  Set<Circle> _circle = HashSet<Circle>();

  late GoogleMapController _mapController;
  late BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygon();
    _setPolylines();
    _setCircle();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/noodle_icon.png',
    );
  }

  void _setPolygon() {
    List<LatLng> polygonLatLongs = <LatLng>[
      LatLng(3.00848, 101.80421),
      LatLng(3.00893, 101.80531),
      LatLng(3.00923, 101.80856),
      LatLng(3.00743, 101.80567),
      // LatLng(37.74493, -122.42932),
    ];

    _polygons.add(
      Polygon(
        polygonId: PolygonId('0'),
        points: polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = <LatLng>[
      LatLng(3.00848, 101.80421),
      LatLng(3.00893, 101.80531),
      LatLng(3.00923, 101.80856),
      LatLng(3.00743, 101.80567),
      LatLng(3.00848, 101.80421),
    ];

    _polylines.add(
      Polyline(
        polylineId: PolylineId('0'),
        points: polylineLatLongs,
        color: Colors.purple,
        width: 1,
      ),
    );
  }

  void _setCircle() {
    _circle.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(3.000984, 101.787125),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, 0.5)),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(3.000984, 101.787125),
          infoWindow: InfoWindow(
            title: 'Kajang',
            snippet: 'An Interesting City',
          ),
          icon: _markerIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(3.000984, 101.787125),
              zoom: 12,
            ),
            markers: _markers,
            polygons: _polygons,
            polylines: _polylines,
            circles: _circle,
            myLocationEnabled: true,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: const Text('Coding with curry'),
          ),
        ],
      ),
    );
  }
}
