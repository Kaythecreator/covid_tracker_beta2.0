import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'main.dart';
class MythsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myths(),
      routes: {
        '/mainPage' : (context)=>MyApp(),
      },
    );
  }
}
class myths extends StatefulWidget {
  @override
  _mythsState createState() => _mythsState();
}

class _mythsState extends State<myths> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LiquidSwipe(
        pages: <Container>[
          Container(
            color: Colors.white,
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
      if(page == 1)
      {
        print(page);
        Navigator.pushNamed(context, '/mainPage');
      }
    });
  }
}

