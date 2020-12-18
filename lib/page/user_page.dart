import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('我的'),
          ),
          body: ListView(
            children: <Widget>[_getUserHeader()],
          )),
    );
  }

  Widget _getUserHeader() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFE43B3A), Color(0xFF07157)])),
      child: Stack(
        children: <Widget>[
          // 顶部 布局 头像 用户名 (京享值 小白信用 标签
          Container(
            margin: EdgeInsets.only(left: 21, bottom: 50),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 36.0,
                  backgroundImage: AssetImage("assets/image/luke.png"),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "jd_2ddsadsdasda",
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xFFFDE5E3)),
                        ),
                        Container(
                          padding: EdgeInsets.all(2.0),
                          margin: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.edit,
                            color: Colors.red,
                            size: 12.0,
                          ),
                        )
                      ],
                    ),
                    Text("用户名：LUke_JD",
                        style: TextStyle(
                            fontSize: 16.0, color: Color(0xFFFABBB7))),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 2.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFC74A3D),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "京享值 777",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 2.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFC74A3D),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "小白信用 87.5",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          // 顶部 下方布局 Plus
          Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: Container(
                // color: Colors.black,
                height: 35,
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    // Image.asset(
                    //   "assets/image/vip.png",
                    //   height: 25.0,
                    //   width: 25.0,
                    // ),
                    Icon(
                      Icons.person_pin,
                      size: 18,
                      color: Colors.yellow,
                    ),
                    Text(
                      "PLUS",
                      style: TextStyle(fontSize: 16.0, color: Colors.yellow),
                    ),
                    Container(
                      height: 10,
                      width: 1.5,
                      color: Colors.yellow,
                      margin: EdgeInsets.all(8.0),
                    ),
                    Text(
                      "每月5张运费券",
                      style: TextStyle(color: Colors.yellow, fontSize: 14.0),
                    ),
                    Spacer(),
                    Text(
                      "立即查看",
                      style: TextStyle(color: Colors.yellow, fontSize: 14.0),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.yellow,
                      size: 16,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
