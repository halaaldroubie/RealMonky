import 'package:food_ordering_sp1/core/data/models/apis/category_model.dart';
import 'package:food_ordering_sp1/core/data/models/apis/meal_model.dart';
import 'package:food_ordering_sp1/core/data/repositories/category_repository.dart';
import 'package:food_ordering_sp1/core/data/repositories/meal_repository%20.dart';
import 'package:food_ordering_sp1/core/enums/connectivity_status.dart';
import 'package:food_ordering_sp1/core/enums/message_type.dart';
import 'package:food_ordering_sp1/core/enums/opertion_type.dart';
import 'package:food_ordering_sp1/core/enums/request_status.dart';
import 'package:food_ordering_sp1/core/services/base_controller.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends BaseController {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<MealModel> mealList = <MealModel>[].obs;
  RxBool isOnlne = true.obs;
  bool get isCategoryLoading =>
      requestStatus == RequestStatus.LOADING &&
      opertionType == OpertionType.CATEGORY;

  bool get isMealLoading =>
      requestStatus == RequestStatus.LOADING &&
      opertionType == OpertionType.MEAL;

  @override
  void onInit() {
    getAllCategory();
    getAllMeal();
    super.onInit();
  }

  @override
  void onReady() {
    checkConnection();
    super.onReady();
  }

  void checkConnection() {
    connectivityService.connectivityStatusController.stream.listen((event) {
      isOnlne.value = event == ConnectivityStatus.ONLINE;
    });
  }

  void getAllCategory() {
    runLoadingFutuerFunction(
        type: OpertionType.CATEGORY,
        function: CategoryRepository().getAll().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            categoryList.addAll(r);
          });
        }));
  }

  void getAllMeal() {
    runLoadingFutuerFunction(
        type: OpertionType.MEAL,
        function: MealRepository().getAll().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            mealList.addAll(r);
          });
        }));
  }

  void addToCart(MealModel model) {
    cartService.addToCart(
        model: model,
        count: 1,
        afterAdd: () {
          CustomToast.showMessage(
              message: 'Added', messageType: MessageType.SUCCESS);
        });
  }
}
