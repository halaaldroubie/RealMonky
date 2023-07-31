import 'dart:convert';

import 'package:food_ordering_sp1/core/data/models/apis/token_info.dart';
import 'package:food_ordering_sp1/core/data/models/cart_model.dart';
import 'package:food_ordering_sp1/core/enums/data_type.dart';
import 'package:food_ordering_sp1/main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceRepository {
  SharedPreferences globalSharedPreferenc = Get.find();

  //!--- Keys -----
  String PREF_FIRST_LUNCH = 'first_lunch';
  String PREF_LOGGED_IN = 'logged_in';
  String PREF_TOKEN = 'token';
  String PREF_APP_LANG = 'app_lang';
  String PREF_CART_LIST = 'cart_list';
  String PREF_SUB_STATUS = 'sub_status';

  void setFirstLunch(bool value) {
    setPreferenc(
      dataType: DataType.BOOL,
      key: PREF_FIRST_LUNCH,
      value: value,
    );
  }

  bool getFirstLunch() {
    if (Get.find<SharedPreferences>().containsKey(PREF_FIRST_LUNCH)) {
      return getPreferenc(key: PREF_FIRST_LUNCH);
    } else {
      return true;
    }
  }

  void setTokenIno(TokenInfo value) {
    setPreferenc(
      dataType: DataType.STRING,
      key: PREF_TOKEN,
      value: jsonEncode(value.toJson()),
    );
  }

  TokenInfo? getTokenInfo() {
    if (globalSharedPreferenc.containsKey(PREF_TOKEN)) {
      return TokenInfo.fromJson(
        jsonDecode(getPreferenc(key: PREF_TOKEN)),
      );
    } else {
      return null;
    }
  }

  void setAppLanguage(String value) {
    setPreferenc(
      dataType: DataType.STRING,
      key: PREF_APP_LANG,
      value: value,
    );
  }

  String getAppLanguage() {
    if (globalSharedPreferenc.containsKey(PREF_APP_LANG)) {
      return getPreferenc(key: PREF_APP_LANG);
    } else {
      return 'ar';
    }
  }

  void setCartList(List<CartModel> list) {
    setPreferenc(
      dataType: DataType.STRING,
      key: PREF_CART_LIST,
      value: CartModel.encode(list),
    );
  }

  List<CartModel> getCartList() {
    if (globalSharedPreferenc.containsKey(PREF_CART_LIST)) {
      return CartModel.decode(getPreferenc(key: PREF_CART_LIST));
    } else {
      return [];
    }
  }

  void setSubStatus(bool value) {
    setPreferenc(
      dataType: DataType.BOOL,
      key: PREF_SUB_STATUS,
      value: value,
    );
  }

  bool getSubStatus() {
    if (Get.find<SharedPreferences>().containsKey(PREF_SUB_STATUS)) {
      return getPreferenc(key: PREF_SUB_STATUS);
    } else {
      return true;
    }
  }

  bool get isLoggedIn => getTokenInfo() != null ? true : false;

  //!--- Main Function -------
  setPreferenc(
      {required DataType dataType,
      required String key,
      required dynamic value}) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPreferenc.setInt(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPreferenc.setDouble(key, value);
        break;
      case DataType.STRING:
        await globalSharedPreferenc.setString(key, value);
        break;
      case DataType.STRINGLIST:
        await globalSharedPreferenc.setStringList(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPreferenc.setBool(key, value);
        break;
    }
  }

  dynamic getPreferenc({required String key}) {
    return globalSharedPreferenc.get(key);
  }
}
