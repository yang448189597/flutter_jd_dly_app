import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/config/jd_app.dart';
import 'package:flutter_jd_dly/model/produc_detail_model.dart';
import 'package:flutter_jd_dly/net/net_request.dart';

class ProvductDetailProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errotMsg = '';

  loadProductData({String id}) {
    ProductDetailModel model;
    isLoading = true;
    isError = false;
    errotMsg = '';

    NetRequest().requestData(JdApi.PRODUCTIONS_DETAIL).then((res) {
      isLoading = false;
      // print(res.data);
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          // 将数组里
          ProductDetailModel tmpModel = ProductDetailModel.fromJson(item);
          if (tmpModel.partData.id == id) {
            model = tmpModel;
            print(model.toJson());
          }
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
