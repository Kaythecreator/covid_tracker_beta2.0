import 'package:covid_tracker_beta/datasource.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index){
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
                      Text(suggestionList[index]['country'], style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlack),),
                      Image.network(suggestionList[index]['countryInfo']['flag'], width: 60, height: 50,),                    ],
                  ),
                ),
                Expanded(child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('CONFIRMED:' + suggestionList[index]['cases'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      Text('ACTIVE:' + suggestionList[index]['active'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                      Text('RECOVERED:' + suggestionList[index]['recovered'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      Text('DEATHS:' + suggestionList[index]['deaths'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                ))
              ],
            ),
          )
      );
    });
  }
}
