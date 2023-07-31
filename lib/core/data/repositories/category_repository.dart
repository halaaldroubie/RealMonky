import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_ordering_sp1/core/data/models/apis/category_model.dart';
import 'package:food_ordering_sp1/core/data/models/common_respons.dart';
import 'package:food_ordering_sp1/core/data/network/endpoints/category_endpoints.dart';
import 'package:food_ordering_sp1/core/data/network/network_config.dart';
import 'package:food_ordering_sp1/core/enums/request_type.dart';
import 'package:food_ordering_sp1/core/utils/network_util.dart';

class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CategoryEndpoints.getAll,
        headers:
            NetwrokConfig.getHeaders(needAuth: false, type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<CategoryModel> resultList = [];

          commonResponse.data!.forEach(
            (element) {
              resultList.add(CategoryModel.fromJson(element));
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
