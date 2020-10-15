import 'dart:convert';

import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/main.dart';
import 'package:covid_tracker_beta/panels/MostActive.dart';
import 'package:covid_tracker_beta/panels/MostCases.dart';
import 'package:covid_tracker_beta/panels/MostRecovered.dart';
import 'package:covid_tracker_beta/panels/mosteffectedcountries.dart';
import 'package:covid_tracker_beta/panels/worldwidepanel.dart';
import 'package:covid_tracker_beta/searchRegion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class most extends StatefulWidget {
  @override
  _mostState createState() => _mostState();
}

class _mostState extends State<most> {

  List countryCaseData;
  fetchCountryCaseData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryCaseData = jsonDecode(response.body);
    });
  }

  List countryDeathData;
  fetchCountryDeathData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=deaths');
    setState(() {
      countryDeathData = jsonDecode(response.body);
    });
  }

  List countryActiveData;
  fetchCountryActiveData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=active');
    setState(() {
      countryActiveData = jsonDecode(response.body);
    });
  }

  List countryRecoveredData;
  fetchCountryRecoveredData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=recovered');
    setState(() {
      countryRecoveredData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryCaseData();
    fetchCountryActiveData();
    fetchCountryDeathData();
    fetchCountryRecoveredData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Most Affected',
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
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildAffectedCases(),
          _buildAffectedActive(),
          _buildAffectedRecovered(),
          _buildAffectedDeaths(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildAffectedDeaths() {
    return SliverToBoxAdapter(
      child: Container(
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
                : MostAffectedPanel(
              countryData: countryDeathData,
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAffectedActive() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.orange,
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
                'Most Affected: Active Cases',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            countryActiveData == null
                ? Container()
                : MostActivePanel(
              countryData: countryActiveData,
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAffectedCases() {
    return SliverToBoxAdapter(
      child: Container(
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
                : MostCasesPanel(
              countryData: countryCaseData,
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAffectedRecovered() {
    return SliverToBoxAdapter(
      child: Container(
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
                : MostRecoveredPanel(
              countryData: countryRecoveredData,
            ),
          ],
        ),
      ),
    );
  }

}
