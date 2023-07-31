import 'package:dartz/dartz.dart';
import 'package:food_ordering_sp1/core/data/models/apis/token_info.dart';
import 'package:food_ordering_sp1/core/data/models/common_respons.dart';
import 'package:food_ordering_sp1/core/data/network/endpoints/user_endpoints.dart';
import 'package:food_ordering_sp1/core/data/network/network_config.dart';
import 'package:food_ordering_sp1/core/enums/request_type.dart';
import 'package:food_ordering_sp1/core/utils/network_util.dart';

class UserRepository {
  Future<Either<String, TokenInfo>> login({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: UserEndpoints.login,
          headers:
              NetwrokConfig.getHeaders(needAuth: false, type: RequestType.POST),
          body: {
            'userName': email,
            'password': password,
          }).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(TokenInfo.fromJson(
            commonResponse.data ?? {},
          ));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

   uploadfile() {
    NetworkUtil.sendMultipartRequest(url: 'url', type: RequestType.GET);
  }
}
