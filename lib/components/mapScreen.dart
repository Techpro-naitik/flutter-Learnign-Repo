import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng? startLocation;
  LatLng? endLocation;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  bool isLoading = true;

  final String googleApiKey = "";

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    try {
      LocationPermission permission =
          await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied");
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      startLocation =
          LatLng(position.latitude, position.longitude);

      // Destination (change if needed)
      endLocation = const LatLng(28.4595, 77.0266);

      addMarkers();
      await getRoute();

    } catch (e) {
      debugPrint("ERROR: $e");
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void addMarkers() {
    markers.add(
      Marker(
        markerId: const MarkerId("start"),
        position: startLocation!,
        infoWindow: const InfoWindow(title: "Start Location"),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId("end"),
        position: endLocation!,
        infoWindow: const InfoWindow(title: "End Location"),
      ),
    );
  }

  Future<void> getRoute() async {
    
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineRequest request = PolylineRequest(
      origin: PointLatLng(
        startLocation!.latitude,
        startLocation!.longitude,
      ),
      destination: PointLatLng(
        endLocation!.latitude,
        endLocation!.longitude,
      ),
      mode: TravelMode.driving,
    );

    PolylineResult result =
        await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey:googleApiKey,
      request:request,
    );
  debugPrint("Polyline Status: ${result.status}");
debugPrint("Polyline Error: ${result.errorMessage}");
    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          width: 6,
          color: Colors.blue,
        ),
      );
    } else {
      debugPrint("Polyline error: ${result.errorMessage}");
    }
  }

  Future<void> moveCamera() async {
    final controller = await _controller.future;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        startLocation!.latitude <= endLocation!.latitude
            ? startLocation!.latitude
            : endLocation!.latitude,
        startLocation!.longitude <= endLocation!.longitude
            ? startLocation!.longitude
            : endLocation!.longitude,
      ),
      northeast: LatLng(
        startLocation!.latitude >= endLocation!.latitude
            ? startLocation!.latitude
            : endLocation!.latitude,
        startLocation!.longitude >= endLocation!.longitude
            ? startLocation!.longitude
            : endLocation!.longitude,
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Directions Example")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: startLocation!,
                zoom: 14,
              ),
              markers: markers,
              polylines: polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) async {
                if (!_controller.isCompleted) {
                  _controller.complete(controller);
                }
                await moveCamera();
              },
            ),
    );
  }
}