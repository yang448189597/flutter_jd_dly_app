import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageProvider>(
      create: (context) {
        var provider = new HomePageProvider();
        provider.loadHomePageData();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: Consumer<HomePageProvider>(builder: (_, provider, __) {
          return Container();
        }),
      ),
    );
  }
}
