import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/page/cart_page.dart';
import 'package:flutter_jd_dly/page/categroy_page.dart';
import 'package:flutter_jd_dly/page/user_page.dart';
import 'package:flutter_jd_dly/page/home_page.dart';

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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "购物车"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "我的"),
          ],
        ),
        body: IndexedStack(
          // 层布局控件 可以存放多个widget 但是只显示一个
          children: [HomePage(), CartPage(), CategroyPage(), UserPage()],
        ),
      ),
    );
  }
}
