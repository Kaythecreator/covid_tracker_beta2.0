import 'package:covid_tracker_beta/datasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                  color: primaryBlack,
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Row(
                  children: [
                    Text('FAQs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                    Icon(Icons.arrow_forward, color: Colors.white,)
                  ],
                )
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: primaryBlack,
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Row(
                children: [
                  Text('FAQs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  Icon(Icons.arrow_forward, color: Colors.white,)
                ],
              )
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: primaryBlack,
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Row(
                children: [
                  Text('FAQs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  Icon(Icons.arrow_forward, color: Colors.white,)
                ],
              )
          ),
        ],
      )
    );
  }
}
