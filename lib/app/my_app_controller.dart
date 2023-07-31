import 'package:food_ordering_sp1/core/enums/connectivity_status.dart';
import 'package:food_ordering_sp1/core/services/base_controller.dart';
import 'package:food_ordering_sp1/core/services/connectivity_service.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';

class MyAppController extends BaseController {
  ConnectivityStatus connectivityStatus = ConnectivityStatus.ONLINE;

  set setConnectivityStatus(ConnectivityStatus value) {
    connectivityStatus = value;
  }

  void listenForConnectivityStatus() {
    connectivityService.connectivityStatusController.stream.listen((event) {
      setConnectivityStatus = event;
    });
  }

  @override
  void onInit() {
    listenForConnectivityStatus();
    super.onInit();
  }
}
