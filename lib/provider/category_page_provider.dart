import 'package:flutter/material.dart';
import 'package:flutter_jd_dly/config/jd_app.dart';
import 'package:flutter_jd_dly/model/category_content_model.dart';
import 'package:flutter_jd_dly/net/net_request.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<String> categoryNavList = [];
  List<CategoryContentModel> categoryContentList = [];
  int tabIndex = 0;

  void loadCategoryPageData() {
    NetRequest().requestData(JdApi.CATEGORY_NAV).then((res) {
      isLoading = false;
      if (res.data is List) {
        for (var i = 0; i < res.data.length; i++) {
          categoryNavList.add(res.data[i]);
        }
        // 默认显示第一个数据
        loadCategoryContentData(this.tabIndex);
      }
      notifyListeners();
      // print(res.data);
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }

// 分类右侧
  void loadCategoryContentData(int index) {
    this.tabIndex = index;
    isLoading = true;
    categoryContentList.clear();
    notifyListeners();

    // 请求数据
    var data = {"title": categoryNavList[index]};
    NetRequest()
        .requestData(JdApi.CATEGORY_CONTENT, data: data, method: 'post')
        .then((res) {
      if (res.data is List) {
        for (var item in res.data) {
          CategoryContentModel tmpModel = CategoryContentModel.fromJson(item);
          categoryContentList.add(tmpModel);
        }
      }
      isLoading = false;
      notifyListeners();
      print(res.data);
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }
}
