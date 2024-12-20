import 'package:dance_studios_finder/pages/dance_studios_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'info Studio Page',
      home: DanceStudiosListPage()
    );
  }
}