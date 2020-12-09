import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Text("Dly_jd_app"),
      ),
    );
  }
}
