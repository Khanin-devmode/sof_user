import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';
import 'package:sof_user/features/user_rep/domain/user_rep_state.dart';
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
        .getUserRepHistory(user.userId, 1, () {});

    userRepScrollCtrl.addListener(() {
      int pageToLoad = ref.read(repPageToLoadNumber);

      if ((userRepScrollCtrl.position.pixels ==
              userRepScrollCtrl.position.maxScrollExtent) &&
          !isLoading) {
        setState(() {
          isLoading = true;
        });
        ref
            .read(userRepNotifierProvider.notifier)
            .getUserRepHistory(user.userId, pageToLoad, () {
          ref.read(repPageToLoadNumber.notifier).update((state) => state + 1);
          setState(() {
            isLoading = false;
          });
        });
      } else {}
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userRepHistory = ref.watch(userRepNotifierProvider);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Reputation History'),
        ),
        body: UserRepColumnWidget(
            user: user,
            userRepScrollCtrl: userRepScrollCtrl,
            userRepHistory: userRepHistory,
            ref: ref,
            isLoading: isLoading));
  }
}

class UserRepColumnWidget extends StatelessWidget {
  const UserRepColumnWidget(
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
          return Column(
            children: [
              Center(
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 160,
                    width: 160,
                    imageUrl: user.imgUrl,
                    placeholder: (context, url) => const Icon(
                      Icons.face,
                      size: 36,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (userRepHistory.isEmpty) const CircularProgressIndicator()
            ],
          );
        }
        if (index != userRepHistory.length) {
          UserRep rep = userRepHistory[index];
          return Card(
            child: ListTile(
              title: Text(rep.repType),
            ),
          );
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
