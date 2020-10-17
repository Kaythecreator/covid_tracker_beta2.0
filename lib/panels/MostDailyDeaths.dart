import 'package:covid_tracker_beta/datasource.dart';
import 'package:flutter/material.dart';

class MostDailyDeathsPanel extends StatelessWidget {

  final List countryData;

  const MostDailyDeathsPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
                children: [
                  Image.network(countryData[index]['countryInfo']['flag'], width: 25, height: 25,),

                  SizedBox(width: 10,),
                  Text(countryData[index]['country'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                  SizedBox(width: 10,),
                  Text('Deaths:' + '   ' + countryData[index]['todayDeaths'].toString(), style: TextStyle(color: primaryBlack, fontWeight: FontWeight.w900),),

                ]
            ),
          );
        },
        itemCount: 5,),
    );
  }
}
