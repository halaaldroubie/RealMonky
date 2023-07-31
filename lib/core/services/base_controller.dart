import 'package:bot_toast/bot_toast.dart';
import 'package:food_ordering_sp1/core/enums/opertion_type.dart';
import 'package:food_ordering_sp1/core/enums/request_status.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  var requestStatus = RequestStatus.DEFAULT.obs;
  var opertionType = OpertionType.NONE.obs;

  set setRequestStatus(RequestStatus value) {
    requestStatus.value = value;
  }

  set setOpertionType(OpertionType value) {
    opertionType.value = value;
  }

  Future runFutuerFunction({required Future function}) async {
    checkConnection(() async {
      await function;
    });
  }

  Future runLoadingFutuerFunction(
      {required Future function,
      OpertionType? type = OpertionType.NONE}) async {
    checkConnection(() async {
      setRequestStatus = RequestStatus.LOADING;
      setOpertionType = type!;
      await function;
      setRequestStatus = RequestStatus.DEFAULT;
      setOpertionType = OpertionType.NONE;
    });
  }

  Future runFullLoadingFutuerFunction(
      {required Future function,
      OpertionType? type = OpertionType.NONE}) async {
    checkConnection(() async {
      customLoader();
      await function;
      BotToast.closeAllLoading();
    });
  }
}
