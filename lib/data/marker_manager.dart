import 'package:dance_studios_finder/pages/studio_info_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerManager {
  Set<Marker> createMarkers(BuildContext context, List filteredStudios) {
    final Set<Marker> markers = {};

    for (final studio in filteredStudios) {
      final marker = Marker(
        markerId: MarkerId(studio['id'].toString()),
        position: LatLng(studio['latitude'], studio['longitude']),
        infoWindow: InfoWindow(
          title: studio['name'],
          snippet: studio['address'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudioInfoPage(studio: studio)
              )
            );
          }
        ),
      );
      markers.add(marker);
    }
    return markers;
  }
}