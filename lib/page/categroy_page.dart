import 'package:flutter/material.dart';

class CategroyPage extends StatefulWidget {
  CategroyPage({Key key}) : super(key: key);

  @override
  _CategroyPageState createState() => _CategroyPageState();
}

class _CategroyPageState extends State<CategroyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('分类'),
          ),
          body: Container()),
    );
  }
}
