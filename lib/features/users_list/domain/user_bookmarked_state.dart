import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/sqlite_service.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

class UserBookmarkedNotifier extends StateNotifier<List<UserModel>> {
  UserBookmarkedNotifier() : super([]);

  final bkmSqliteService = BkmSqliteService();

  void getUser() async {
    await bkmSqliteService.getUsers().then((users) {
      state = users;
    });
  }

  void addUser(UserModel user) async {
    await bkmSqliteService.insertUser(user).then((value) {
      state = [...state, user];
    });
  }

  void removeUser(UserModel removingUser) async {
    await bkmSqliteService.removeUser(removingUser.userId).then((value) {
      state =
          state.where((user) => user.userId != removingUser.userId).toList();
    });
  }
}

final userBookmarkedNotifierProvider =
    StateNotifierProvider<UserBookmarkedNotifier, List<UserModel>>((ref) {
  return UserBookmarkedNotifier();
});
