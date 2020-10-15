import 'dart:convert';
import 'dart:math';

import 'package:covid_tracker_beta/DailyPage.dart';
import 'package:covid_tracker_beta/TotalPage.dart';
import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/detailsPage.dart';
import 'package:covid_tracker_beta/infoPanel.dart';
import 'package:covid_tracker_beta/main.dart';
import 'package:covid_tracker_beta/panels/CustomAppBar.dart';
import 'package:covid_tracker_beta/panels/dailyPanel.dart';
import 'package:covid_tracker_beta/panels/mosteffectedcountries.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_tracker_beta/panels/worldwidepanel.dart';
import 'package:covid_tracker_beta/searchRegion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
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
          '/total': (context) => total(),
          '/daily': (context) => daily(),
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
        centerTitle: false,
        title: Text(
          'COVID-19 TRACKER',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildCovid(screenHeight),
          _buildPrevention(screenHeight),
          _buildTotal(screenHeight),
          _buildDaily(screenHeight),
          _buildMostAffected(screenHeight),
          _FAQ(screenHeight),
          _buildMyth(screenHeight),
          _buildDonate(screenHeight),
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
                ),
                Text('Are You Feeling Sick?', style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'If you feel sick with any COVID-19 symptoms, please visit the website below for more info.',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {
                        launch('https://www.cdc.gov/coronavirus/2019-ncov/if-you-are-sick/steps-when-sick.html');
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.open_in_browser,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Visit Website',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Colors.blue,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }

  SliverToBoxAdapter _buildPrevention(double screenHeight){
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 0),
              blurRadius: 10)
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prevention Techniques',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: prevention.map((e) => Column(children: [
                Image.asset(
                    e.keys.first,
                        height: screenHeight * 0.12
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Text(e.values.first, style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
                  textAlign: TextAlign.center,
                ),
              ],))
                .toList(),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTotal(double screenHeight) {
    return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.orange, boxShadow: [
              ]
              ),
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 150,
              width: 400,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 0), blurRadius: 25)
              ]),
              child: LiquidSwipe(
                enableSlideIcon: true,
                positionSlideIcon: 0,
                onPageChangeCallback: pageTotal,
                enableLoop: true,
                pages: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 0.0,
                    ),
                    padding: const EdgeInsets.all(25.0),
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.blue,

                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Total Cases',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'Swipe left to discover the total cases\nglobally and regionally.',                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 0.0,
                    ),
                    padding: const EdgeInsets.all(25.0),
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Total Cases',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'Swipe left to discover the total cases\nglobally and regionally.',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        )
                      ],
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

  SliverToBoxAdapter _buildDaily(double screenHeight) {
    return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.orange, boxShadow: [
              ]
              ),
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 150,
              width: 400,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 0),
                    blurRadius: 15)
              ]),
              child: LiquidSwipe(
                enableSlideIcon: true,
                positionSlideIcon: 0,
                onPageChangeCallback: pageChangeDaily,
                enableLoop: true,
                pages: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 0.0,
                    ),
                    padding: const EdgeInsets.all(25.0),
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Daily Cases',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'Swipe left to discover the daily cases\nglobally and regionally.',                              style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            ),
                              maxLines: 2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 0.0,
                    ),
                    padding: const EdgeInsets.all(25.0),
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.blue,

                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Daily Cases',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'Swipe left to discover the daily cases\nglobally and regionally.',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        )
                      ],
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

  SliverToBoxAdapter _buildMostAffected(double screenHeight) {
    return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.orange, boxShadow: [
              ]
              ),
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 150,
              width: 400,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 0), blurRadius: 25)
              ]),
              child: LiquidSwipe(
                enableSlideIcon: true,
                positionSlideIcon: 0,
                onPageChangeCallback: pageChangeCallback,
                enableLoop: true,
                pages: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 0.0,
                    ),
                    padding: const EdgeInsets.all(25.0),
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.blue,

                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Most Affected',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'Swipe left to discover the countries with the\nmost deaths, total cases, and recovered.',                              style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                              maxLines: 2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 0.0,
                    ),
                    padding: const EdgeInsets.all(25.0),
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Most Affected',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'Swipe left to discover the countries with the\nmost deaths, total cases, and recovered.',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        )
                      ],
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


            //worldData == null
               // ? CircularProgressIndicator()
               // : WorldwidePanel(
                //    worldData: worldData,
                 // ),

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
          width: 400,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 0),
                blurRadius: 15)
          ]),
          child: LiquidSwipe(
            enableSlideIcon: true,
            positionSlideIcon: 0,
            onPageChangeCallback: pageChangeCallback,
            enableLoop: false,
            pages: [
              Container(
                height: 70,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  'FAQ',
                  style: TextStyle(
                      color: primaryBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 70,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blue,
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  'FAQ',
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
                    color: Colors.black26,
                    offset: Offset(0, 0),
                    blurRadius: 15)
              ]),
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 70,
              width: 400,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 0), blurRadius: 25)
              ]),
              child: LiquidSwipe(
                enableSlideIcon: true,
                positionSlideIcon: 0,
                onPageChangeCallback: pageChange,
                enableLoop: true,
                pages: [
                  Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Myths Debunked',
                      style: TextStyle(
                          color: primaryBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Myths Debunked',
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

  SliverToBoxAdapter _buildDonate (double screenHeight) {
    return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 0),
                    blurRadius: 15)
              ]),
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 70,
              width: 400,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 0), blurRadius: 25)
              ]),
              child: LiquidSwipe(
                enableSlideIcon: true,
                positionSlideIcon: 0,
                onPageChangeCallback: pageChangeAgain,
                enableLoop: true,
                pages: [
                  Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Donate',
                      style: TextStyle(
                          color: primaryBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Donate',
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
        launch('https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
  }
    });
  }

  pageChangeAgain(int page3){
    print(page3);
    setState(() {
      page = page3;
      if (page == 1){
        launch('https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate');
      }
    });
  }

  pageTotal(int page4){
    print(page4);
    setState(() {
      page = page4;
      if (page == 1){
        Navigator.pushNamed(context, '/total');
      }
    });
  }


  pageChangeDaily(int page5){
    print(page5);
    setState(() {
      page = page5;
      if (page == 1){
        Navigator.pushNamed(context, '/daily');
      }
    });
  }

}
