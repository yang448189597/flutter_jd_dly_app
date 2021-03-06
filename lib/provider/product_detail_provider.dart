import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/config/jd_app.dart';
import 'package:flutter_jd_dly/model/produc_detail_model.dart';
import 'package:flutter_jd_dly/net/net_request.dart';

class ProvductDetailProvider with ChangeNotifier {
  ProductDetailModel model;
  bool isLoading = false;
  bool isError = false;
  String errotMsg = '';

  loadProductData({String id}) {
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

  // 分期切换
  void changeBaiTiaoSelected(int index) {
    if (this.model.baitiao[index].select == false) {
      for (int i = 0; i < this.model.baitiao.length; i++) {
        if (i == index) {
          this.model.baitiao[i].select = true;
        } else {
          this.model.baitiao[i].select = false;
        }
      }
      notifyListeners();
    }
  }

  // 数量赋值
  void changeProductCount(int count) {
    if (count > 0 && model.partData.count != count) {
      this.model.partData.count = count;
      notifyListeners();
    }
  }
}
