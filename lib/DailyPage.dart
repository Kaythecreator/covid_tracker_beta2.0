import 'dart:convert';

import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/main.dart';
import 'package:covid_tracker_beta/panels/MostDailyCases.dart';
import 'package:covid_tracker_beta/panels/MostDailyDeaths.dart';
import 'package:covid_tracker_beta/panels/MostDailyRecovered.dart';
import 'package:covid_tracker_beta/panels/dailyusaPanel.dart';
import 'package:covid_tracker_beta/panels/dailyworldPanel.dart';
import 'package:covid_tracker_beta/searchDailyRegion.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid_tracker_beta/panels/usaPanel.dart';
import 'package:covid_tracker_beta/panels/worldwidepanel.dart';
import 'package:covid_tracker_beta/panels/usaPanel.dart';
import 'package:covid_tracker_beta/searchRegion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class daily extends StatefulWidget {
  @override
  _dailyState createState() => _dailyState();
}

class _dailyState extends State<daily> {

  Map dailyworldData;
  fetchDailyworldData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      dailyworldData = jsonDecode(response.body);
    });
  }

  Map dailyusaData;
  fetchdailyusaData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries/usa');
    setState(() {
      dailyusaData = jsonDecode(response.body);
    });
  }

  List countryCaseData;
  fetchCountryCaseData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=todayCases');
    setState(() {
      countryCaseData = jsonDecode(response.body);
    });
  }

  List countryDeathData;
  fetchCountryDeathData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=todayDeaths');
    setState(() {
      countryDeathData = jsonDecode(response.body);
    });
  }


  List countryRecoveredData;
  fetchCountryRecoveredData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=todayRecovered');
    setState(() {
      countryRecoveredData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchDailyworldData();
    fetchdailyusaData();
    fetchCountryCaseData();
    fetchCountryDeathData();
    fetchCountryRecoveredData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Daily Cases',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white
          ),
        ),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            iconSize: 35,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchDailyPage()));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildCases(),
          _buildSpace(),
          _buildGraphs(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildCases() {
    return SliverToBoxAdapter(
      child:
      CarouselSlider(
        options: CarouselOptions(
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 2000),
            viewportFraction: 1,
            height: 320
        ),
        items: [
          Container(
            margin: EdgeInsets.all(15),
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
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                dailyworldData == null
                    ? CircularProgressIndicator()
                    : DailyworldPanel(
                  dailyworldData: dailyworldData,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
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
                        'USA',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryBlack),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                dailyusaData == null
                    ? CircularProgressIndicator()
                    : DailyusaPanel(
                  dailyusaData: dailyusaData,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSpace() {
    return SliverToBoxAdapter(
      child: Container(
        height: 30,
      ),
    );
  }

  SliverToBoxAdapter _buildGraphs() {
    return SliverToBoxAdapter(
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Most Affected Countries',
                style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Swipe left',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: false,
                  autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  viewportFraction: 1,
                  height: 395
              ),
              items: [

                Container(
                  margin: EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: primaryBlack,
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
                          'Most Affected: Deaths',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      countryDeathData == null
                          ? Container()
                          : MostDailyDeathsPanel(
                        countryData: countryDeathData,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.red,
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
                          'Most Affected: Cases',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      countryCaseData == null
                          ? Container()
                          : MostDailyCasesPanel(
                        countryData: countryCaseData,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.green,
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
                          'Most Affected: Recovered',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      countryRecoveredData == null
                          ? Container()
                          : MostDailyRecoveredPanel(
                        countryData: countryRecoveredData,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }


}
