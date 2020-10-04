

import 'package:covid_tracker_beta/FaqSect.dart';
import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/homepage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),

  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: primaryBlack
            ),
          )
        ],
      ),
    );
  }
}
