import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/page/index_page.dart';
import 'package:flutter_jd_dly/provider/bottom_navi_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider.value(
    value: BottomNaviProvider(),
    child: MyApp(), // 监听顶级的widget
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: IndexPage());
  }
}
