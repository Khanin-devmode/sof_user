import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/services.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

final pageToLoadNumber = StateProvider<int>((ref) => 2);

class UserListNotifier extends StateNotifier<List<UserModel>> {
  UserListNotifier() : super([]);

  var api = StackApiServices();

  Future<void> getUserByPage(int nthPage) async {
    List<UserModel> userList = await api.getUsers(nthPage);
    state = state + userList;
  }
}

final userListNotifierProvider =
    StateNotifierProvider<UserListNotifier, List<UserModel>>((ref) {
  return UserListNotifier();
});
