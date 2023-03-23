import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';

class UserRepApiService {
  final int pageSize = 100;

  Future<List<UserRep>> getRep(int userId, int pageNumber) async {
    String endPoint =
        'https://api.stackexchange.com//2.3/users/$userId/reputation-history?page=$pageNumber&pagesize=100&site=stackoverflow';

    final response = await http.get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => UserRep.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
