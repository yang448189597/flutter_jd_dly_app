import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/config/jd_app.dart';
import 'package:flutter_jd_dly/model/product_info_model.dart';

import 'package:flutter_jd_dly/net/net_request.dart';

class ProvductListProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errotMsg = '';
  List<ProductionInfoModel> list = List();

  loadProductListData() {
    isLoading = true;
    isError = false;
    errotMsg = '';

    NetRequest().requestData(JdApi.PRODUCTIONS_LIST).then((res) {
      isLoading = false;
      print(res.data);
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          // 将数组里
          ProductionInfoModel tmpModel = ProductionInfoModel.fromJson(item);
          list.add(tmpModel);
        }
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
