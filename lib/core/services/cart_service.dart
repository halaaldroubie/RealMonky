import 'package:food_ordering_sp1/core/data/models/apis/meal_model.dart';
import 'package:food_ordering_sp1/core/data/models/cart_model.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:get/get.dart';

class CartService {
  RxList<CartModel> cartList = storage.getCartList().obs;

  RxInt cartCount = 0.obs;

  RxDouble subTotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble deliverFees = 0.0.obs;
  RxDouble total = 0.0.obs;

  CartService() {
    getCartCount();
    calcCartTotal();
  }

  void addToCart({
    required MealModel model,
    required int count,
    Function? afterAdd,
  }) {
    double mealTotal = calcMealTotal(count: count, model: model);
    if (getCartModel(model) != null) {
      int index = getIndex(getCartModel(model)!);
      cartList[index].count = cartList[index].count! + count;
      cartList[index].total = cartList[index].total! + mealTotal;
    } else {
      cartList.add(CartModel(
        count: count,
        total: mealTotal,
        meal: model,
      ));
    }
    storage.setCartList(cartList);
    cartCount.value += count;
    if (afterAdd != null) afterAdd();

    calcCartTotal();
  }

  void removeFromCartList(CartModel model) {
    cartList.remove(model);
    cartCount.value -= model.count!;

    storage.setCartList(cartList);

    calcCartTotal();
  }

  void changeCount(
      {required bool incress,
      required CartModel model,
      Function? afterChange}) {
    CartModel? result = getCartModel(model.meal!);

    int index = getIndex(result!);

    if (incress) {
      result.count = result.count! + 1;
      result.total = result.total! + model.meal!.price!.toDouble();
      cartCount.value += 1;
      calcCartTotal();
    } else {
      if (result.count! > 1) {
        result.count = result.count! - 1;
        result.total = result.total! - model.meal!.price!.toDouble();
        cartCount.value -= 1;
        calcCartTotal();
      }
    }

    cartList.remove(result);
    cartList.insert(index, result);

    storage.setCartList(cartList);
    if (afterChange != null) afterChange();
  }

  void clearCart() {
    cartList.clear();
    cartCount.value = getCartCount();
    calcCartTotal();

    storage.setCartList(cartList);
  }

  double calcMealTotal({required MealModel model, required int count}) {
    return (model.price! * count).toDouble();
  }

  CartModel? getCartModel(MealModel model) {
    try {
      return cartList.firstWhere(
        (element) => element.meal!.id == model.id,
      );
    } catch (e) {
      return null;
    }
  }

  int getCartCount() {
    cartCount.value = cartList.fold(
        0, (previousValue, element) => previousValue + element.count!);

    return cartCount.value;
  }

  int getIndex(CartModel model) => cartList.indexOf(model);

  void calcCartTotal() {
    subTotal.value = 0.0;
    tax.value = 0.0;
    deliverFees.value = 0.0;
    total.value = 0.0;

    subTotal.value = cartList.fold(
        0, (previousValue, element) => previousValue + element.total!);
    tax.value += subTotal.value * taxAmount;
    deliverFees.value += (subTotal.value + tax.value) * deliverAmount;
    total.value = subTotal.value + deliverFees.value + tax.value;
  }
}
