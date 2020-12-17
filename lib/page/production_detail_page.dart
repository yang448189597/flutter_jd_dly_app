import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/model/produc_detail_model.dart';
import 'package:flutter_jd_dly/provider/bottom_navi_provider.dart';
import 'package:flutter_jd_dly/provider/cart_provider.dart';
import 'package:flutter_jd_dly/provider/product_detail_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

                // 获取数据
                ProductDetailModel model = provider.model;
                String baitiaoTitle = "[首单支付，白条立减享受优惠]";
                for (var item in model.baitiao) {
                  if (item.select == true) {
                    baitiaoTitle = item.desc;
                  }
                }
                print(model.toJson());

                return Stack(
                  children: <Widget>[
                    // 主题内容
                    ListView(
                      children: <Widget>[
                        // 轮播图
                        buildSwiperContainer(model),

                        // 标题
                        buildTitleContainer(model),

                        // 价格
                        buildPriceContainer(model),

                        // 白条支付
                        buildPayContainer(
                            context, baitiaoTitle, model, provider),

                        // 商品数量
                        buildCountContainer(context, model, provider)
                      ],
                    ),

                    // 底部菜单栏
                    buildBottomPositioned(context, model)
                  ],
                );
              }),
            )));
  }

  Positioned buildBottomPositioned(
      BuildContext context, ProductDetailModel model) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: Color(0xFFe8e8ed), width: 1))),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: InkWell(
                child: Container(
                  height: 60,
                  color: Color(0xFFffffff),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            child: Icon(Icons.shopping_cart),
                            width: 40,
                            height: 30,
                          ),
                          Consumer<CartProvider>(
                              builder: (_, cartProvider, __) {
                            return Positioned(
                                right: 0.0,
                                child: cartProvider.getAllcount() > 0
                                    ? Container(
                                        padding: EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(11.0)),
                                        child: Text(
                                          "${cartProvider.getAllcount()}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : Container());
                          })
                        ],
                      ),
                      Text(
                        "购物车",
                        style: TextStyle(fontSize: 13.0),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // 购物车
                  // 先回到顶层的page
                  Navigator.popUntil(context, ModalRoute.withName("/"));
                  // 跳转到购物车
                  Provider.of<BottomNaviProvider>(context, listen: false)
                      .changeBottomNaviInder(2);
                },
              )),
              Expanded(
                  child: InkWell(
                child: Container(
                  height: 60,
                  color: Color(0xFFe93b3d),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "加入购物车",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // 加入购物车
                  Provider.of<CartProvider>(context, listen: false)
                      .addToCart(model.partData);
                  Fluttertoast.showToast(
                      msg: "成功加入购物车！！",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      fontSize: 16.0);
                },
              )),
            ],
          ),
        ));
  }

  Container buildCountContainer(BuildContext context, ProductDetailModel model,
      ProvductDetailProvider provider) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                width: 1,
                color: Color(0xFFe8e8ed),
              ),
              bottom: BorderSide(width: 1, color: Color(0xFFe8e8ed)))),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text(
              "已选",
              style: TextStyle(color: Color(0xFF999999)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text("${model.partData.count}件"),
              ),
            ),
            Icon(Icons.more_horiz)
          ],
        ),
        onTap: () {
          // 选择商品个数
          return showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return ChangeNotifierProvider.value(
                  value: provider,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                      ),
                      // 顶部：图片 价格 和 数量信息
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // 从左侧
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Image.asset(
                              "assets${model.partData.loopImgUrl[0]}",
                              width: 90,
                              height: 90,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30),
                              Text(
                                "￥${model.partData.price}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFe93b3d)),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "已选${model.partData.count}件",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: IconButton(
                              icon: Icon(Icons.close),
                              iconSize: 20,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),

                      // 中间：数量 加减号
                      Container(
                        margin: EdgeInsets.only(top: 90.0, bottom: 50.0),
                        padding: EdgeInsets.only(top: 40.0, left: 15.0),
                        child: Consumer<ProvductDetailProvider>(
                            builder: (_, tmpProvider, __) {
                          return Row(
                            children: <Widget>[
                              Text("数量"),
                              Spacer(),
                              InkWell(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  color: Color(0xFFF7f7f7),
                                  child: Center(
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xFFB0B0B0)),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // 减号 点击事件
                                  int tmpCount = model.partData.count;
                                  tmpCount--;
                                  provider.changeProductCount(tmpCount);
                                },
                              ),
                              SizedBox(width: 2),
                              Container(
                                width: 35,
                                height: 35,
                                child: Center(
                                    child: Text("${model.partData.count}")),
                              ),
                              SizedBox(width: 2),
                              InkWell(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  color: Color(0xFFF7f7f7),
                                  child: Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xFFB0B0B0)),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // 加号 点击事件
                                  int tmpCount = model.partData.count;
                                  tmpCount++;
                                  provider.changeProductCount(tmpCount);
                                },
                              ),
                            ],
                          );
                        }),
                      ),

                      // 底部：加入购物车按钮
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              color: Color(0xFFe93b3d),
                              child: Text(
                                "加入购物车",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {
                              // 加入购物车
                              Provider.of<CartProvider>(context, listen: false)
                                  .addToCart(model.partData);
                              Navigator.pop(context);
                            },
                          ))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Container buildPayContainer(BuildContext context, String baitiaoTitle,
      ProductDetailModel model, ProvductDetailProvider provider) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                width: 1,
                color: Color(0xFFe8e8ed),
              ),
              bottom: BorderSide(width: 1, color: Color(0xFFe8e8ed)))),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text(
              "支付",
              style: TextStyle(color: Color(0xFF999999)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text("$baitiaoTitle"),
              ),
            ),
            Icon(Icons.more_horiz)
          ],
        ),
        onTap: () {
          // 选择支付方式 白条支付 分期
          buildShowBaiTiao(context, model, provider);
        },
      ),
    );
  }

  Future buildShowBaiTiao(BuildContext context, ProductDetailModel model,
      ProvductDetailProvider provider) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider<ProvductDetailProvider>.value(
            value: provider,
            child: Stack(
              children: <Widget>[
                // 顶部标题栏
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 40.0,
                      color: Color(0xFFF3F2F8),
                      child: Center(
                        child: Text("打白条购买",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      width: 40.0,
                      height: 40.0,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.close),
                          iconSize: 20,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                // 主题列表
                Container(
                    margin: EdgeInsets.only(top: 40.0, bottom: 50.0),
                    child: ListView.builder(
                        itemCount: model.baitiao.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8.0),
                                    child: Consumer<ProvductDetailProvider>(
                                      builder: (_, tmpProvider, __) {
                                        return Image.asset(
                                            model.baitiao[index].select
                                                ? "assets/image/selected.png"
                                                : "assets/image/unselect.png",
                                            width: 20,
                                            height: 20);
                                      },
                                    )),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("${model.baitiao[index].desc}"),
                                      Text("${model.baitiao[index].tip}"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              // 选择白条分期类型
                              provider.changeBaiTiaoSelected(index);
                            },
                          );
                        })),

                // 底部按钮
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        color: Color(0xFFE4393C),
                        child: Center(
                          child: Text(
                            "立即打白条",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        // 确定分期并返回
                        Navigator.pop(context);
                      },
                    ))
              ],
            ),
          );
        });
  }

  Container buildPriceContainer(ProductDetailModel model) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Text(
        "￥${model.partData.price}",
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFe93b3d)),
      ),
    );
  }

  Container buildTitleContainer(ProductDetailModel model) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Text(model.partData.title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
    );
  }

  Container buildSwiperContainer(ProductDetailModel model) {
    return Container(
        color: Colors.white,
        height: 400,
        child: Swiper(
          itemCount: model.partData.loopImgUrl.length,
          pagination: SwiperPagination(),
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              "assets${model.partData.loopImgUrl[index]}",
              width: double.infinity,
              height: 400,
              fit: BoxFit.fill,
            );
          },
        ));
  }
}
