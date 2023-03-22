import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';
import 'package:sof_user/features/users_list/domain/user_bookmarked_state.dart';
import 'package:sof_user/features/users_list/domain/user_list_state.dart';

class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  UserListState createState() => UserListState();
}

class UserListState extends ConsumerState<UserListPage> {
  ScrollController userListScrollCtrl = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    ref.read(userListNotifierProvider.notifier).getUserByPage(1, () {});

    userListScrollCtrl.addListener(() {
      int pageToLoad = ref.read(pageToLoadNumber);

      if ((userListScrollCtrl.position.pixels ==
              userListScrollCtrl.position.maxScrollExtent) &&
          !isLoading) {
        setState(() {
          isLoading = true;
        });
        ref.read(userListNotifierProvider.notifier).getUserByPage(pageToLoad,
            () {
          ref.read(pageToLoadNumber.notifier).update((state) => state + 1);
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
    final userList = ref.watch(userListNotifierProvider);
    final bkmList = ref.watch(userBookmarkedNotifierProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Stack Overflow User'),
        ),
        body: userList.isNotEmpty
            ? Column(children: [
                Expanded(
                  child: ListView.builder(
                    controller: userListScrollCtrl,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      UserModel user = userList[index];
                      return Card(
                        child: ListTile(
                          leading: ClipOval(
                            child: CachedNetworkImage(
                              width: 48,
                              height: 48,
                              fadeInDuration: const Duration(milliseconds: 0),
                              fadeOutDuration: const Duration(milliseconds: 0),
                              imageUrl: user.imgUrl,
                              placeholder: (context, url) => const Icon(
                                Icons.face,
                                size: 36,
                              ),
                            ),
                          ),
                          title: Text(user.displayName),
                          subtitle: Text(user.location),
                          trailing: SizedBox(
                            width: 140,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Reputation'),
                                    Text(user.reputation.toString())
                                  ],
                                ),
                                const VerticalDivider(
                                  indent: 8,
                                  thickness: 1,
                                ),
                                bkmList.contains(user)
                                    ? IconButton(
                                        icon: const Icon(Icons.bookmark),
                                        onPressed: () => ref
                                            .read(userBookmarkedNotifierProvider
                                                .notifier)
                                            .removeUser(user))
                                    : IconButton(
                                        icon:
                                            const Icon(Icons.bookmark_outline),
                                        onPressed: () => ref
                                            .read(userBookmarkedNotifierProvider
                                                .notifier)
                                            .addUser(user))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 12.0, bottom: 12),
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox(),
              ])
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
