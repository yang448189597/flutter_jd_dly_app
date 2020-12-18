import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/model/produc_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<PartData> models = [];

  Future<void> addToCart(PartData data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> list = [];

    // // // 存入缓存
    // list.add(json.encode(data.toJson()));
    // preferences.setStringList("cartInfo", list);

    // print(data.toJson());

    list = preferences.getStringList("cartInfo");
    models.clear();

    if (list == null) {
      print("没有数据");
      list.add(json.encode(data.toJson()));
      // list.add("没有数据");
      preferences.setStringList("cartInfo", list);
      // 更新本地数据
      models.add(data);
      notifyListeners();
    } else {
      print("缓存中有数据");
      // 判断缓存中是否有对象的商品
      // 定义临时数组
      List<String> tmpList = [];
      bool isUpdated = false;
      for (var i = 0; i < list.length; i++) {
        PartData tmpData = PartData.fromJson(json.decode(list[i]));
        // 判断商品id
        if (tmpData.id == data.id) {
          tmpData.count = data.count;
          isUpdated = true;
        }

        // 放入数组中
        String tmpDataStr = json.encode(tmpData.toJson());
        tmpList.add(tmpDataStr);
        models.add(tmpData);
      }

      // 如果缓存里数组没有现在添加的商品
      if (isUpdated == false) {
        String str = json.encode(data.toJson());
        tmpList.add(str);
        models.add(data);
      }

      // 存入缓存
      preferences.setStringList("cartInfo", tmpList);

      notifyListeners();
    }
  }

  // 获取购物车商品的数量
  int getAllcount() {
    int count = 0;
    for (PartData data in this.models) {
      count += data.count;
    }
    return count;
  }

  // 获取购物车商品
  void getCartList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> list = [];
    list = preferences.getStringList("cartInfo");
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        PartData tmpData = PartData.fromJson(json.decode(list[i]));
        models.add(tmpData);
      }
      notifyListeners();
    }
  }

  // 删除商品
  void removeFromCart(String id) async {
    // 从缓存中删除
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> list = [];
    list = preferences.getStringList("cartInfo");

    // 便利缓存
    for (var i = 0; i < list.length; i++) {
      PartData tmpdata = PartData.fromJson(json.decode(list[i]));
      if (tmpdata.id == id) {
        list.remove(list[i]);
        break;
      }
    }

    // 遍历本地数据
    for (var i = 0; i < models.length; i++) {
      if (this.models[i].id == id) {
        this.models.remove(this.models[i]);
        break;
      }
    }

    // 缓存重新赋值
    preferences.setStringList("cartInfo", list);
    notifyListeners();
  }
}
