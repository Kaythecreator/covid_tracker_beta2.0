import 'dart:convert';

import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/detailsPage.dart';
import 'package:covid_tracker_beta/mythsPage.dart';
import 'package:covid_tracker_beta/infoPanel.dart';
import 'package:covid_tracker_beta/main.dart';
import 'package:covid_tracker_beta/panels/CustomAppBar.dart';
import 'package:covid_tracker_beta/panels/mosteffectedcountries.dart';
import 'package:covid_tracker_beta/panels/worldwidepanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: {
        '/detailsPage': (context) => detailsPage(),
        '/mythsPage': (context) => myths(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  int page = 0;

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 28,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_3),
            iconSize: 28,
            onPressed: () {},
          )
        ],
        title: Text(
          'COVID-19 TRACKER',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildCovid(screenHeight),
          _buildHeader(screenHeight),
          _buildAffected(screenHeight),
          _FAQ(screenHeight),
          _buildMyth(screenHeight)
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildCovid(double screenHeight) {
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ],
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'COVID-19',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'If you feel sick with any COVID-19 symptoms, please call or text us immediately for help',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {},
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Call Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Colors.white,
                    ),
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {},
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.open_in_browser,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Visit Website',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            )));
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 5), blurRadius: 10)
        ], color: Colors.white, borderRadius: BorderRadius.circular(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'WorldWide',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryBlack),
                  ),
                ],
              ),
            ),
            worldData == null
                ? CircularProgressIndicator()
                : WorldwidePanel(
                    worldData: worldData,
                  ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAffected(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 0), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                'Most Affected Countries',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            countryData == null
                ? Container()
                : MostAffectedPanel(
                    countryData: countryData,
                  ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _FAQ(double screenHeight) {
    return SliverToBoxAdapter(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.orange, boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 0), blurRadius: 10)
          ]),
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          height: 70,
          width: 320,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 0), blurRadius: 25)
          ]),
          child: LiquidSwipe(
            enableSlideIcon: true,
            positionSlideIcon: 0,
            onPageChangeCallback: pageChangeCallback,
            enableLoop: false,
            pages: [
              Container(
                height: 70,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  'Covid-19 FAQ',
                  style: TextStyle(
                      color: primaryBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 70,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blue,
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  'Covid-19 FAQ',
                  style: TextStyle(
                      color: primaryBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    ));
  }

  SliverToBoxAdapter _buildMyth (double screenHeight) {
    return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 0), blurRadius: 10)
              ]),
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 70,
              width: 320,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 0), blurRadius: 25)
              ]),
              child: LiquidSwipe(
                enableSlideIcon: true,
                positionSlideIcon: 0,
                onPageChangeCallback: pageChange,
                enableLoop: false,
                pages: [
                  Container(
                    height: 70,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Covid-19 Myths Debunked',
                      style: TextStyle(
                          color: primaryBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Covid-19 Myths Debunked',
                      style: TextStyle(
                          color: primaryBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        )
    );
  }

  pageChangeCallback(int lpage) {
    print(lpage);
    setState(() {
      page = lpage;
      if (page == 1) {
        Navigator.pushNamed(context, '/detailsPage');
      }
    });
  }

  pageChange(int page2){
    print(page2);
    setState(() {
      page = page2;
      if (page == 1){
        Navigator.push(context, MaterialPageRoute(builder:(context) => MythsPage()));
  }
    });
  }
}
