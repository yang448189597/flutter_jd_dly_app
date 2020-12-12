import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/model/category_content_model.dart';
import 'package:flutter_jd_dly/page/prodction_list_page.dart';
import 'package:flutter_jd_dly/provider/category_page_provider.dart';
import 'package:flutter_jd_dly/provider/product_list_provider.dart';

import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryPageProvider>(
        create: (context) {
          var provider = new CategoryPageProvider();
          provider.loadCategoryPageData();
          return provider;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("分类"),
          ),
          body: Container(
            child: Consumer<CategoryPageProvider>(
              builder: (_, provider, __) {
                // 加载动画 fixed
                if (provider.isLoading &&
                    provider.categoryNavList.length == 0) {
                  return Center(child: CupertinoActivityIndicator());
                }

                // 捕获异常
                if (provider.isError) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(provider.errorMsg),
                      OutlineButton(
                        child: Text("刷新"),
                        onPressed: () {
                          provider.loadCategoryPageData();
                        },
                      )
                    ],
                  ));
                }

                return Row(
                  children: <Widget>[
                    buildNaviLeftContainer(provider),
                    Expanded(
                        child: Stack(
                      children: <Widget>[
                        bulidCategoryContent(provider.categoryContentList),
                        provider.isLoading
                            ? Center(child: CupertinoActivityIndicator())
                            : Container()
                      ],
                    ))
                  ],
                );
              },
            ),
          ),
        ));
  }

  // 分类左侧
  Container buildNaviLeftContainer(CategoryPageProvider provider) {
    return Container(
      width: 90,
      child: ListView.builder(
          itemCount: provider.categoryNavList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.only(top: 15),
                  color: provider.tabIndex == index
                      ? Colors.white
                      : Color(0xFFF8F8F8),
                  child: Text(
                    provider.categoryNavList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: provider.tabIndex == index
                            ? Color(0xFFe93b3d)
                            : Color(0xFF333333),
                        fontWeight: FontWeight.w500),
                  )),
              onTap: () {
                // print(index);
                provider.loadCategoryContentData(index);
              },
            );
          }),
    );
  }

  // 分类右侧
  Widget bulidCategoryContent(List<CategoryContentModel> categoryContentList) {
    List<Widget> list = List<Widget>();

    //处理数据 title
    for (var i = 0; i < categoryContentList.length; i++) {
      list.add(Container(
        height: 30.0,
        margin: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: Text(
          "${categoryContentList[i].title}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ));

      //处理数据 商品
      List<Widget> descList = List<Widget>();
      for (var j = 0; j < categoryContentList[i].desc.length; j++) {
        descList.add(InkWell(
          child: Container(
            width: 60.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset(
                  "assets${categoryContentList[i].desc[j].img}",
                  width: 55,
                  height: 55,
                ),
                Text("${categoryContentList[i].desc[j].text}")
              ],
            ),
          ),
          onTap: () {
            // 点击事件 跳转商品页面
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<ProvductListProvider>(
                      create: (context) {
                        ProvductListProvider provider = ProvductListProvider();
                        provider.loadProductListData();
                        return provider;
                      },
                      child: Consumer<ProvductListProvider>(
                        builder: (_, provider, __) {
                          return Container(
                            child: ProductListPage(
                                title:
                                    "${categoryContentList[i].desc[j].text}"),
                          );
                        },
                      ),
                    )));
          },
        ));
      }

      // 把descList 追加进list
      list.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 7.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.start,
          children: descList,
        ),
      ));
    }

    return Container(
        width: double.infinity,
        color: Colors.white,
        child: ListView(children: list));
  }
}
