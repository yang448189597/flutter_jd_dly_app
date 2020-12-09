import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/model/home_page_model.dart';
import 'package:flutter_jd_dly/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

            // 获取model 中的数据
            HomePageModel model = provider.model;
            print(model.toJson());

            return ListView(
              children: <Widget>[
                // 轮播图
                buildAspectRatio(model),
                // 图标分类
                bulidLogos(model),
              ],
            );
            // return Container();
          }),
        ),
      ),
    );
  }

  AspectRatio buildAspectRatio(HomePageModel model) {
    return AspectRatio(
      aspectRatio: 72 / 35,
      child: Swiper(
        itemCount: model.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset('assets${model.swipers[index].image}');
        },
      ),
    );
  }

// 图标分类
  Widget bulidLogos(HomePageModel model) {
    // 定义一个list 数组
    List<Widget> list = List<Widget>();

    for (var i = 0; i < model.logos.length; i++) {
      list.add(Container(
        width: 60.0,
        child: Column(children: <Widget>[
          Image.asset("assets${model.logos[i].image}", width: 50, height: 50),
          Text("${model.logos[i].title}")
        ]),
      ));
    }

    return Container(
      color: Colors.white,
      height: 170,
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        spacing: 10.0, //横向布局的时候有一个间隙
        runSpacing: 7.0, //竖向布局的时候有一个间隙
        alignment: WrapAlignment.spaceBetween, //等比例的间隙
        children: list,
      ),
    );
  }
}
