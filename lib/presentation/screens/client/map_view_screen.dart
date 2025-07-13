import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dukascan_go/domain/models/store.dart';

class MapViewScreen extends StatefulWidget {
  final List<Store> stores;

  const MapViewScreen({required this.stores});

  @override
  _MapViewScreenState createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    for (final store in widget.stores) {
      final marker = Marker(
        markerId: MarkerId(store.id),
        position: LatLng(store.location.latitude, store.location.longitude),
        infoWindow: InfoWindow(
          title: store.name,
        ),
      );
      _markers[store.id] = marker;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Replace with a default location
          zoom: 11.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
