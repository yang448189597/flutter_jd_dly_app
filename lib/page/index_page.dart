import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/page/cart_page.dart';
import 'package:flutter_jd_dly/page/categroy_page.dart';
import 'package:flutter_jd_dly/page/home_page.dart';
import 'package:flutter_jd_dly/page/user_page.dart';
import 'package:flutter_jd_dly/provider/bottom_navi_provider.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Consumer<BottomNaviProvider>(
          builder: (_, mProvider, __) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed, //超过三个以上需要 type
              currentIndex: mProvider.bottomNaviIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: "分类"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: "购物车"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: "我的"),
              ],
              onTap: (index) {
                // print(index);
                mProvider.changeBottomNaviInder(index);
              },
            );
          },
        ),
        body: Consumer<BottomNaviProvider>(
          builder: (_, mProvider, __) => IndexedStack(
            index: mProvider.bottomNaviIndex,
            // 层布局控件 可以存放多个widget 但是只显示一个
            children: [
              HomePage(),
              CategoryPage(),
              CartPage(),
              UserPage(),
            ],
          ),
        ));
  }
}
