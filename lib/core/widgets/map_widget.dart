import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/services/location_service.dart';
import 'package:uasd_app/injection_container.dart';

class MapWidget extends StatefulWidget {
  final String coordinates;
  const MapWidget({super.key, required this.coordinates});

  @override
  MapState createState() => MapState();
}

class MapState extends State<MapWidget> {
  final LocationService locationService = getIt<LocationService>();

  @override
  Widget build(BuildContext context) {
    final coordinates = _parseCoordinates(
        widget.coordinates); // se obtienen las coordenadas de un String

    if (coordinates == null) {
      return Center(
        child: Text(
          'No se pudo obtener la locación del evento.',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      );
    }

    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(coordinates[0], coordinates[1]),
        initialZoom: 15.0,
      ),
      children: [
        _buildTileLayer(
          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          "com.example.app",
        ),
        _buildMarkerLayer(coordinates: widget.coordinates),
      ],
    );
  }

  // Parseo de coordenadas que vienen como String a un List<double>
  List<double>? _parseCoordinates(String coordinates) {
    try {
      final parts = coordinates.split(',').map((part) => part.trim()).toList();
      if (parts.length != 2) return null;

      final latitude = double.tryParse(parts[0]);
      final longitude = double.tryParse(parts[1]);

      if (latitude == null ||
          longitude == null ||
          latitude.isNaN ||
          latitude.isInfinite ||
          longitude.isNaN ||
          longitude.isInfinite ||
          latitude < -90 ||
          latitude > 90 ||
          longitude < -180 ||
          longitude > 180) {
        return null;
      }

      return [latitude, longitude];
    } catch (e) {
      return null;
    }
  }

  // Construye el template del mapa
  TileLayer _buildTileLayer(String urlTemplate, String userAgentPackageName) {
    return TileLayer(
      urlTemplate: urlTemplate,
      userAgentPackageName: userAgentPackageName,
    );
  }

  // Marcador de la posición en el mapa
  MarkerLayer _buildMarkerLayer({required String coordinates}) {
    final location = _parseCoordinates(coordinates);

    if (location == null) {
      return MarkerLayer(markers: []);
    }

    return MarkerLayer(
      markers: [
        Marker(
            point: LatLng(location[0], location[1]),
            child: Icon(
              size: 60,
              Icons.location_pin,
              color: AppConstants.primaryColor,
            )),
      ],
    );
  }
}
