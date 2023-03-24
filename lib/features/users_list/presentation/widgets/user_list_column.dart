import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

import 'user_card.dart';

class UserListView extends StatelessWidget {
  const UserListView({
    super.key,
    required this.userListScrollCtrl,
    required this.userList,
    required this.bkmList,
    required this.ref,
    required this.isLoading,
  });

  final ScrollController userListScrollCtrl;
  final List<UserModel> userList;
  final List<UserModel> bkmList;
  final WidgetRef ref;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(6),
      controller: userListScrollCtrl,
      itemCount: userList.length + 1,
      itemBuilder: (context, index) {
        if (index != userList.length) {
          UserModel user = userList[index];
          return UserCard(user: user, bkmList: bkmList, ref: ref);
        } else {
          return Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox(),
            ),
          );
        }
      },
    );
  }
}
