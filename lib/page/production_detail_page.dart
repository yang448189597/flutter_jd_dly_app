import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/provider/product_detail_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  ProductDetailPage({Key key, this.id}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(title: Text("手机")),
            body: Container(
              child:
                  Consumer<ProvductDetailProvider>(builder: (_, provider, __) {
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
                            provider.loadProductData(id: widget.id); // 重新加载数据
                          },
                        )
                      ],
                    ),
                  );
                }

                return Container();
              }),
            )));
  }
}
