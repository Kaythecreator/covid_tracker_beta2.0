import 'package:flutter/material.dart';

class TotalCase extends StatefulWidget {
  @override
  _TotalCaseState createState() => _TotalCaseState();
}

class _TotalCaseState extends State<TotalCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildHeader(),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
        padding: const EdgeInsets.all(20),
    );
  }

}
