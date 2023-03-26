import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/user_list_service.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

final pageToLoadNumber = StateProvider<int>((ref) => 2);

class UserListNotifier extends StateNotifier<List<UserModel>> {
  UserListNotifier() : super([]);

  var api = UserListApiService();

  Future<void> getUserByPage(int n) async {
    await api.getUsers(n).then((value) => state = state + value);
  }
}

final userListNotifierProvider =
    StateNotifierProvider<UserListNotifier, List<UserModel>>((ref) {
  return UserListNotifier();
});
