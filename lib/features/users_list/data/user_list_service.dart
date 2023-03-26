import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sof_user/features/users_list/data/user_model.dart';

class UserListApiService {
  final int pageSize = 100;

  Future<List<UserModel>> getUsers(int pageNumber) async {
    String endPoint =
        'https://api.stackexchange.com/2.3/users?page=$pageNumber&pagesize=$pageSize&order=desc&sort=reputation&site=stackoverflow&key=QWPxw89168Pe)Y9rTPIZlA((';
    final response = await http.get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
