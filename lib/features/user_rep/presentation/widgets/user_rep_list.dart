import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';
import 'package:sof_user/features/user_rep/presentation/widgets/user_rep_card.dart';
import 'package:sof_user/features/user_rep/presentation/widgets/user_rep_header.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

class UserRepList extends StatelessWidget {
  const UserRepList(
      {super.key,
      required this.userRepScrollCtrl,
      required this.userRepHistory,
      required this.ref,
      required this.isLoading,
      required this.user});

  final ScrollController userRepScrollCtrl;
  final List<UserRep> userRepHistory;
  final WidgetRef ref;
  final bool isLoading;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(6),
      controller: userRepScrollCtrl,
      itemCount: userRepHistory.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return UserRepHeader(user: user, userRepHistory: userRepHistory);
        }
        if (index != userRepHistory.length) {
          UserRep rep = userRepHistory[index];
          return UserRepCard(rep: rep);
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

