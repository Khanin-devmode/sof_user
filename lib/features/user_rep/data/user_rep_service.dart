import 'package:dio/dio.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';

class UserRepApiService {
  final int pageSize = 100;

  final cancelToken = CancelToken();

  Future<List<UserRep>> getRep(int userId, int pageNumber) async {
    final dio = Dio();
    String endPoint =
        'https://api.stackexchange.com//2.3/users/$userId/reputation-history?page=$pageNumber&pagesize=100&site=stackoverflow';

    final response = await dio.get(endPoint, cancelToken: cancelToken);

    if (response.statusCode == 200) {
      final List result = response.data['items'];
      return result.map((e) => UserRep.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
