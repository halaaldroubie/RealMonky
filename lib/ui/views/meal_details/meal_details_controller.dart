import 'package:food_ordering_sp1/core/data/models/apis/meal_model.dart';
import 'package:food_ordering_sp1/core/data/models/cart_model.dart';
import 'package:food_ordering_sp1/core/services/base_controller.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/cart_view/cart_view.dart';
import 'package:food_ordering_sp1/ui/views/main_view/home_view/home_view_controller.dart';
import 'package:get/get.dart';

class MealDetailsController extends BaseController {
  MealDetailsController(MealModel mealModel) {
    model = mealModel;
  }

  MealModel model = MealModel();

  RxInt count = 1.obs;

  void changeCount(bool incress) {
    if (incress)
      count++;
    else {
      if (count > 1) {
        count--;
      }
    }
  }

  double calcTotal() {
    return (count.value * model.price!).toDouble();
  }

  void addToCart() {
    cartService.addToCart(
        model: model,
        count: count.value,
        afterAdd: () {
          Get.to(CartView());
        });
  }
}
