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
  ScrollController bkmUserListScrollCtrl = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    ref.read(userBookmarkedNotifierProvider.notifier).getUser();
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

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userList = ref.watch(userListNotifierProvider);
    final bkmList = ref.watch(userBookmarkedNotifierProvider);
    final bkmListId = bkmList.map((e) => e.userId);

    List<Widget> userListView = <Widget>[
      userList.isNotEmpty
          ? UserListWidget(
              userListScrollCtrl: userListScrollCtrl,
              userList: userList,
              bkmListId: bkmListId,
              ref: ref,
              isLoading: isLoading)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bkmList.isNotEmpty
          ? UserListWidget(
              userListScrollCtrl: bkmUserListScrollCtrl,
              userList: bkmList,
              bkmListId: bkmListId,
              ref: ref,
              isLoading: isLoading)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Stack Overflow User'),
        ),
        body: userListView.elementAt(pageIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_add_outlined),
              label: 'Bookmark',
            ),
          ],
          currentIndex: pageIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}

class UserListWidget extends StatelessWidget {
  const UserListWidget({
    super.key,
    required this.userListScrollCtrl,
    required this.userList,
    required this.bkmListId,
    required this.ref,
    required this.isLoading,
  });

  final ScrollController userListScrollCtrl;
  final List<UserModel> userList;
  final Iterable<int> bkmListId;
  final WidgetRef ref;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(6),
          controller: userListScrollCtrl,
          itemCount: userList.length + 1,
          itemBuilder: (context, index) {
            if (index != userList.length) {
              UserModel user = userList[index];
              return Card(
                child: ListTile(
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      width: 48,
                      height: 48,
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
                            const Text('Reputation'),
                            Text(user.reputation.toString())
                          ],
                        ),
                        const VerticalDivider(
                          indent: 8,
                          thickness: 1,
                        ),
                        bkmListId.contains(user.userId)
                            ? IconButton(
                                icon: const Icon(Icons.bookmark),
                                onPressed: () => ref
                                    .read(
                                        userBookmarkedNotifierProvider.notifier)
                                    .removeUser(user))
                            : IconButton(
                                icon: const Icon(Icons.bookmark_outline),
                                onPressed: () => ref
                                    .read(
                                        userBookmarkedNotifierProvider.notifier)
                                    .addUser(user))
                      ],
                    ),
                  ),
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
        ),
      ),
    ]);
  }
}
