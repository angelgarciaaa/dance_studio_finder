// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/dance_studios_data.dart';
import 'studio_info_page.dart';
import '../data/marker_manager.dart';

class DanceStudiosListPage extends StatefulWidget {
  @override
  _DanceStudiosListPageState createState() => _DanceStudiosListPageState();
}

class _DanceStudiosListPageState extends State<DanceStudiosListPage> {

  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> filteredStudios = danceStudios;

  final markerManager = MarkerManager();

  final List<String> danceStyles = ['Ballet', 'Hip-Hop', 'Salsa', 'Contemporary', 'Latin'];

  List<String> selectedStyles = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Dance Studios'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField( // this also generates a "value", then used to compare with the dance studios names
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Dance studio name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged:(value) {
                setState(() { // Updates the filtered list and markers based on selected filters.
                  filteredStudios = danceStudios.where((studio) { // It's just like a query
                    return studio['name'].toLowerCase().contains(value.toLowerCase()); //We compare the name in lowercase with the value of the controller in lowercase
                  }).toList();
                });
              },
            )
          ),
          Wrap( // For checkboxes to adapt
            spacing: 8,
            children: danceStyles.map((style) {
              return FilterChip(
                label: Text(style),
                selected: selectedStyles.contains(style),
                onSelected: (isSelected) {
                  setState((){
                    if (isSelected) {
                      selectedStyles.add(style);
                    } else {
                      selectedStyles.remove(style);
                    }
                    filteredStudios = danceStudios.where((studio) {
                      final matchesStyle = selectedStyles.isEmpty || studio['danceStyles'].any((style) => selectedStyles.contains(style));
                      return matchesStyle;
                    }).toList(); // We update the list
                  });
                },
              );
            }).toList()
          ),
          Expanded(
            child: ListView.separated( //same as ListView.builder, but with extra parameter "separatorBuilder"
              itemCount: filteredStudios.length,
              itemBuilder: (context, index){
                final studio = filteredStudios[index];
                return ListTile(
                  title: Text(studio['name']),
                  subtitle: Text('${studio['address']}\n${studio['danceStyles'].join(', ')}'),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudioInfoPage(studio: studio) // Here we send the studio to the info page
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index){
                return Divider();
              },
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(60.1655, 24.9364),
                zoom: 13.5,
              ),
              markers: markerManager.createMarkers(context, filteredStudios),
            ),
          ),
        ],
      ),
    );
  }
}