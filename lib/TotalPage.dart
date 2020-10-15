import 'dart:convert';

import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/main.dart';
import 'package:covid_tracker_beta/panels/worldwidepanel.dart';
import 'package:covid_tracker_beta/searchRegion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class total extends StatefulWidget {
  @override
  _totalState createState() => _totalState();
}

class _totalState extends State<total> {

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Total Cases',
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
          _buildCases(),
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
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
        height: 320
      ),
      items: [
        Container(
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
                    Container(
                      decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: IconButton(
                        icon: Icon(Icons.search, color: Colors.white,),
                        iconSize: 25,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage()));
                        },
                      ),
                    )
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
          ],
        ),
    );
  }
  
  SliverToBoxAdapter _buildGraphs() {
    return SliverToBoxAdapter(
      child: Container(
        height: 600,
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
                'Graphs',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
