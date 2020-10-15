import 'package:covid_tracker_beta/datasource.dart';
import 'package:covid_tracker_beta/searchFunction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
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
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {

            showSearch(context: context, delegate: Search(countryData));

          },)
        ],
        title: Text(
          'Search Countries',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: countryData==null?Center(child: CircularProgressIndicator(),): ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Container(
            height: 130,

            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(countryData[index]['country'], style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlack),),
                      Image.network(countryData[index]['countryInfo']['flag'], width: 60, height: 50,),                    ],
                  ),
                ),
                Expanded(child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('CONFIRMED:' + countryData[index]['cases'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      Text('ACTIVE:' + countryData[index]['active'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                      Text('RECOVERED:' + countryData[index]['recovered'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      Text('DEATHS:' + countryData[index]['deaths'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                ))
              ],
            ),
          )
          );
        },
        itemCount: countryData == null ? 0 : countryData.length,
      ),
    );
  }
}
