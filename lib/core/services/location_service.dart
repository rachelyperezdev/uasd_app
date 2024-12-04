import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationService {
  Future<Map<String, String>> getLocation(
      {required double latitude, required double longitude}) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final location = data["display_name"] ?? "Lugar desconocido";

        return {
          "location": location,
        };
      } else {
        throw Exception("Couldn't find event location.");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
