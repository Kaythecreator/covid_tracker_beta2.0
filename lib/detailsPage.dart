import 'package:covid_tracker_beta/datasource.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
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
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 28,
          onPressed: () {},
        ),
        elevation: 0,
        centerTitle: true,
        title: Text('FAQs'),
      ),
      body: LiquidSwipe(
        pages: <Container>[
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
          Container(
            color: Colors.blue,
          )
        ],
        onPageChangeCallback: pageChangeCallback,
        enableSlideIcon: true,
        enableLoop: false,
      ),

    );
  }

  pageChangeCallback(int lpage) {
    print(lpage);
    setState(() {
      page = lpage;
      if (page == 1) {
        print(page);
        Navigator.pushNamed(context, '/mainPage');
      }
    });
  }
}
