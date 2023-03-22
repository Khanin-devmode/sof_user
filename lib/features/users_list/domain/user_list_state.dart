import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/services.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

class UserListNotifier extends StateNotifier<List<UserModel>> {
  UserListNotifier() : super([]);

  Future<void> firstLoad() async {
    var api = StackApiServices();
    List<UserModel> userList = await api.getUsers();
    state = userList;
  }
}

final userListNotifierProvider =
    StateNotifierProvider<UserListNotifier, List<UserModel>>((ref) {
  return UserListNotifier();
});
