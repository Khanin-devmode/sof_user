import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';
import 'package:sof_user/features/user_rep/data/user_rep_service.dart';

final repPageToLoadNumber = StateProvider.autoDispose<int>((ref) => 2);

class UserRepHistoryNotifier extends StateNotifier<List<UserRep>> {
  UserRepHistoryNotifier({required this.api}) : super([]);

  UserRepApiService api;

  Future<void> getUserRepHistory(int userId, int pageNumber) async {
    await api.getRep(userId, pageNumber).then((value) {
      state = state + value;
    });
  }
}

final userRepNotifierProvider =
    StateNotifierProvider.autoDispose<UserRepHistoryNotifier, List<UserRep>>(
        (ref) {
  var api = UserRepApiService();

  ref.onDispose(() => api.cancelToken.cancel());

  return UserRepHistoryNotifier(api: api);
});
