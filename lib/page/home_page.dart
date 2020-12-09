import 'package:flutter/cupertino.dart';
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
        body: Container(
          color: Color(0xFFf4f4f4),
          child: Consumer<HomePageProvider>(builder: (_, provider, __) {
            print(provider.isLoading);
            // 加载动画
            if (provider.isLoading) {
              return Center(child: CupertinoActivityIndicator());
            }
            // 捕获异常
            if (provider.isError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, //组件居中
                  children: <Widget>[
                    Text(provider.errotMsg),
                    OutlineButton(
                      child: Text('刷新'),
                      onPressed: () {
                        provider.loadHomePageData(); // 重新加载数据
                      },
                    )
                  ],
                ),
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
}
