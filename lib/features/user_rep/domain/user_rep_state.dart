import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';
import 'package:sof_user/features/user_rep/data/user_rep_service.dart';

final repPageToLoadNumber = StateProvider.autoDispose<int>((ref) => 2);

class UserRepHistoryNotifier extends StateNotifier<List<UserRep>> {
  UserRepHistoryNotifier() : super([]);

  var api = UserRepApiService();

  Future<void> getUserRepHistory(
      int userId, int pageNumber, Function callBack) async {
    List<UserRep> userRep = await api.getRep(userId, pageNumber);
    state = state + userRep;
    callBack();
  }

  void clearHistory() {
    state = [];
  }
}

final userRepNotifierProvider =
    StateNotifierProvider.autoDispose<UserRepHistoryNotifier, List<UserRep>>(
        (ref) {
  return UserRepHistoryNotifier();
});
