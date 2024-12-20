// ignore_for_file: prefer_const_constructors

// What the first comment does is tell Dart Analyzr not to underline if I don't use const for certain variables 
import 'package:flutter/material.dart';

class StudioInfoPage extends StatelessWidget {

  final Map<String, dynamic> studio; // We define the studio as a map

  StudioInfoPage({required this.studio}); // And here we recieve the studio

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Studio Info'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center( //We put everything into Center, and then using child to just center This part of the text
            child: Text(
              studio['name'],
              style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold
              )
            )
          ),
          Divider(), //This is just a simple line between "Studio Information" and the actual information
          SizedBox(height: 8), //The SizedBoxes I add here are to make a little spacing between each "child"
          Text(
            studio['address'],
            style: TextStyle(
              fontSize: 16
            )
          ),
          SizedBox(height: 8),
          Text(
            'Dance Styles: ${studio['danceStyles'].join(', ')}',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Description:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            studio['description'],
            style: TextStyle(
              fontSize: 16
            ),
          ),
        ],)
      )
    );
  }
}