import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/config/jd_app.dart';
import 'package:flutter_jd_dly/model/home_page_model.dart';
import 'package:flutter_jd_dly/net/net_request.dart';

class HomePageProvider with ChangeNotifier {
  HomePageModel model;
  bool isLoading = false;
  bool isError = false;
  String errotMsg = '';

  loadHomePageData() {
    isLoading = true;
    isError = false;
    errotMsg = '';

    NetRequest().requestData(JdApi.HOME_PAGE).then((res) {
      isLoading = false;
      if (res.code == 200) {
        // print(res.data);
        model = HomePageModel.fromJson(res.data);
      }
      notifyListeners(); //做一个听众，当数据发生变化的时候，通知界面刷新
    }).catchError((error) {
      print(error);
      isLoading = false;
      isError = true;
      errotMsg = error;
      notifyListeners();
    });
  }
}
