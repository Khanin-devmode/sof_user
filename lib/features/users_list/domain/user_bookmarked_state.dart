import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/sqlite_service.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserBookmarkedNotifier extends StateNotifier<List<UserModel>> {
  UserBookmarkedNotifier() : super([]);

  final bkmSqliteService = BkmSqliteService();

  void getUser() async {
    await bkmSqliteService.getUsers().then((users) {
      print(users);
      state = users;
    });
  }

  void addUser(UserModel user) async {
    await bkmSqliteService.insertUser(user);

    state = [...state, user];
  }

  void removeUser(UserModel removingUser) async {
    await bkmSqliteService.deleteUser(removingUser.userId);
    state = state.where((user) => user != removingUser).toList();
  }
}

final userBookmarkedNotifierProvider =
    StateNotifierProvider<UserBookmarkedNotifier, List<UserModel>>((ref) {
  return UserBookmarkedNotifier();
});
