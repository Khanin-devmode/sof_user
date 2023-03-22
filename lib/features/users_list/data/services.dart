import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sof_user/features/users_list/data/user_model.dart';

class StackApiServices {
  final int pageNumber = 1;
  final int pageSize = 100;

  Future<List<UserModel>> getUsers() async {
    String endPoint =
        'https://api.stackexchange.com/2.3/users?page=$pageNumber&pagesize=$pageSize&order=desc&sort=reputation&site=stackoverflow';

    final response = await http.get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

// final stackApiProvider =
//     Provider<StackApiServices>((ref) => StackApiServices());

// final userListProvider = FutureProvider<List<UserModel>>((ref) async {
//   return ref.watch(stackApiProvider).getUsers();
// });
