import 'package:flutter/material.dart';
class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: faqPage(),
    );
  }
}

class faqPage extends StatefulWidget {
  @override
  _faqPageState createState() => _faqPageState();
}

class _faqPageState extends State<faqPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
