import 'dart:convert';

import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/infoPanel.dart';
import 'package:covid_tracker_beta/panels/CustomAppBar.dart';
import 'package:covid_tracker_beta/panels/mosteffectedcountries.dart';
import 'package:covid_tracker_beta/panels/worldwidepanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
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
        title: Text('COVID-19 TRACKER', style: TextStyle(fontSize: 20, color: primaryBlack),),
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildHeader(screenHeight),
          _buildAffected(screenHeight),
          _FAQ(screenHeight)
        ],
      )
    );
  }
  
  
  SliverToBoxAdapter _buildHeader(double screenHeight){
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0,5), blurRadius: 10)],
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '                    WorldWide',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

  SliverToBoxAdapter _buildAffected(double screenHeight){
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0,0), blurRadius: 10)],
          borderRadius: BorderRadius.circular(40)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  'Most Affected Countries',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
SliverToBoxAdapter _FAQ(double screenHeight){
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: LiquidSwipe(
                pages: [
                  Container(
                    height: 300,
                    width: 400,
                    padding: EdgeInsets.all(30),
                    child: Text('COVID-19 Information', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 25), ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0,0), blurRadius: 10)],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 400,
                    padding: EdgeInsets.all(30),
                    child: Text('COVID-19 Information', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25), ),


                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.blue,
                      boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0,0), blurRadius: 10)],
                    ),
                  )
                ],
                enableLoop: true,
                fullTransitionValue: 300,
                enableSlideIcon: true,
                waveType: WaveType.liquidReveal,
                onPageChangeCallback: swipeFinished,
              ),
            ),


          ],
        ),
      ),
    );
}
void swipeFinished(int pageNumber){
    if(pageNumber == 1){
      Navigator.pushNamed(context, '/Faqsect');
    }
}
}

