import 'package:covid_tracker_beta/datasource.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class detailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: detail(),
      routes: {
        '/mainPage': (context) => MyApp(),
      },
    );
  }
}


class detail extends StatefulWidget {
  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 28,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: Text('FAQs'),
      ),
      body:
          Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: DataSource.questionAnswers.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(DataSource.questionAnswers[index]['question'], style: TextStyle(fontWeight: FontWeight.bold),),
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child:
                              Text(DataSource.questionAnswers[index]['answer']))
                    ],
                  );
                }),
          ),
    );
  }

}
