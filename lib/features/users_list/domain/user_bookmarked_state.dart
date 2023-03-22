import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

class UserBookmarkedNotifier extends StateNotifier<List<UserModel>> {
  UserBookmarkedNotifier() : super([]);

  void addUser(UserModel user) {
    state = [...state, user];
  }

  void removeUser(UserModel removingUser) {
    state = state.where((user) => user != removingUser).toList();
  }
}

final userBookmarkedNotifierProvider =
    StateNotifierProvider<UserBookmarkedNotifier, List<UserModel>>((ref) {
  return UserBookmarkedNotifier();
});
