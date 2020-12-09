import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/config/jd_app.dart';
import 'package:flutter_jd_dly/net/net_request.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var data = NetRequest()
        .requestData(JdApi.HOME_PAGE)
        .then((res) => print(res.data));
    print(data);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: Container(),
      ),
    );
  }
}
