import 'dart:convert';

import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/main.dart';
import 'package:covid_tracker_beta/panels/MostActive.dart';
import 'package:covid_tracker_beta/panels/MostCases.dart';
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
    fetchCountryData();
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
          _buildAffectedDeaths(),
          _buildAffectedActive(),
          _buildAffectedCases(),
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
            countryData == null
                ? Container()
                : MostActivePanel(
              countryData: countryData,
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
            countryData == null
                ? Container()
                : MostCasesPanel(
              countryData: countryData,
            ),
          ],
        ),
      ),
    );
  }

}
