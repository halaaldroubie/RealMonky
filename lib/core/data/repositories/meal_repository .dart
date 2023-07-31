import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_ordering_sp1/core/data/models/apis/meal_model.dart';
import 'package:food_ordering_sp1/core/data/models/common_respons.dart';
import 'package:food_ordering_sp1/core/data/network/endpoints/meal_endpoints.dart';
import 'package:food_ordering_sp1/core/data/network/network_config.dart';
import 'package:food_ordering_sp1/core/enums/request_type.dart';
import 'package:food_ordering_sp1/core/utils/network_util.dart';

class MealRepository {
  Future<Either<String, List<MealModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: MealEndpoints.getAll,
        headers: NetwrokConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<MealModel> resultList = [];

          commonResponse.data!.forEach(
            (element) {
              resultList.add(MealModel.fromJson(element));
            },
          );
          return Right(resultList);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
