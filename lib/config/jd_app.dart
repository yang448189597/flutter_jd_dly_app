class JdApi {
  static const String BASE_URL = "https://flutter-jdapi.herokuapp.com/api";
  // 首页数据
  static const String HOME_PAGE = BASE_URL + "/profiles/homepage";
  // 分类导航数据
  static const String CATEGORY_NAV = BASE_URL + 'profiles/navigationleft';
  // 分类页的商品类目的json
  static const String CATEGORY_CONTENT = BASE_URL + 'profiles/navigationRight';
  // 返回的商品列表的json
  static const String PRODUCTIONS_LIST = BASE_URL + 'profiles/productionsList';
  // 返回的商品详情的json
  static const String PRODUCTIONS_DETAIL =
      BASE_URL + 'profiles/productionDetail';
}
