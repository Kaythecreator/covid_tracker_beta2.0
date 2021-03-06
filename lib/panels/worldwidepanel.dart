import 'package:covid_tracker_beta/datasource.dart';
import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {

  final Map worldData;

  const WorldwidePanel({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
        children: [
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.red,

            textColor: Colors.white,
            count: worldData['cases'].toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.orange,

            textColor: Colors.white,
            count: worldData['active'].toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green,

            textColor: Colors.white,
            count: worldData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey[900],

            textColor: Colors.white,
            count: worldData['deaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width/2,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),), Text(count, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),)
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(
              color: Colors.black12,
                offset: Offset(0, 0),
                   blurRadius: 10
            ),  ],

            color: panelColor,

      ),
    );
  }
}

