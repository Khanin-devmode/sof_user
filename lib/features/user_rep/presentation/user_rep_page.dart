import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/user_rep/domain/user_rep_state.dart';
import 'package:sof_user/features/user_rep/presentation/widgets/user_rep_list.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

class UserRepPage extends ConsumerStatefulWidget {
  const UserRepPage({super.key, required this.user});

  final UserModel user;

  @override
  UserRepState createState() => UserRepState(user: user);
}

class UserRepState extends ConsumerState<UserRepPage> {
  UserRepState({required this.user});

  final UserModel user;

  ScrollController userRepScrollCtrl = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    ref
        .read(userRepNotifierProvider.notifier)
        .getUserRepHistory(user.userId, 1);

    userRepScrollCtrl.addListener(
      () {
        int pageToLoad = ref.read(repPageToLoadNumber);
        var currentPosition = userRepScrollCtrl.position.pixels;
        var maxPosition = userRepScrollCtrl.position.maxScrollExtent;
        if ((currentPosition == maxPosition) && !isLoading) {
          setState(() => isLoading = true);
          ref
              .read(userRepNotifierProvider.notifier)
              .getUserRepHistory(
                user.userId,
                pageToLoad,
              )
              .then((value) {
            ref.read(repPageToLoadNumber.notifier).update((state) => state + 1);
            setState(() => isLoading = false);
          });
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userRepHistory = ref.watch(userRepNotifierProvider);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text(user.displayName),
        ),
        body: UserRepList(
            user: user,
            userRepScrollCtrl: userRepScrollCtrl,
            userRepHistory: userRepHistory,
            ref: ref,
            isLoading: isLoading));
  }
}
