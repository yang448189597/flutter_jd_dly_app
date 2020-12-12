import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/model/product_info_model.dart';
import 'package:flutter_jd_dly/provider/product_list_provider.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  ProductListPage({Key key, this.title}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("${widget.title}")),
        body: Container(
          color: Color(0xFFF7F7F7),
          child: Consumer<ProvductListProvider>(
            builder: (_, provider, __) {
              // 加载动画 fixed
              if (provider.isLoading) {
                return Center(child: CupertinoActivityIndicator());
              }

              // 捕获异常
              if (provider.isError) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.errotMsg),
                    OutlineButton(
                      child: Text("刷新"),
                      onPressed: () {
                        provider.loadProductListData();
                      },
                    )
                  ],
                ));
              }

              // 返回数据展示
              return ListView.builder(
                  itemCount: provider.list.length,
                  itemBuilder: (context, index) {
                    ProductionInfoModel model = provider.list[index];
                    print(model.toJson());

                    return InkWell(
                      child: buildProductRow(model),
                      onTap: () {
                        // 点击跳转进单个商品列表的详情页面
                      },
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  Row buildProductRow(ProductionInfoModel model) {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets${model.cover}",
          width: 95,
          height: 120,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5.0),
              Text(
                "￥${model.price}",
                style: TextStyle(fontSize: 16.0, color: Color(0xFFe93b3d)),
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  Text(
                    "${model.comment} 条评价",
                    style: TextStyle(fontSize: 13.0, color: Color(0xFF999999)),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    "好评率${model.rate}",
                    style: TextStyle(fontSize: 13.0, color: Color(0xFF999999)),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ))
      ],
    );
  }
}
