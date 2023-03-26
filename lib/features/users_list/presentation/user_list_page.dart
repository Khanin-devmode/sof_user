import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/domain/user_bookmarked_state.dart';
import 'package:sof_user/features/users_list/domain/user_list_state.dart';
import 'package:sof_user/features/users_list/presentation/widgets/user_list_column.dart';

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
    ref.read(userListNotifierProvider.notifier).getUserByPage(1);

    userListScrollCtrl.addListener(() {
      int pageToLoad = ref.read(pageToLoadNumber);

      var currentPosition = userListScrollCtrl.position.pixels;
      var maxPosition = userListScrollCtrl.position.maxScrollExtent;

      if ((currentPosition == maxPosition) && !isLoading) {
        setState(() => isLoading = true);
        ref
            .read(userListNotifierProvider.notifier)
            .getUserByPage(pageToLoad)
            .then((value) {
          ref.read(pageToLoadNumber.notifier).update((state) => state + 1);
          setState(() => isLoading = false);
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
          ? UserListView(
              userListScrollCtrl: userListScrollCtrl,
              userList: userList,
              bkmListId: bkmListId,
              ref: ref,
              isLoading: isLoading)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bkmList.isNotEmpty
          ? UserListView(
              userListScrollCtrl: bkmUserListScrollCtrl,
              userList: bkmList,
              bkmListId: bkmListId,
              ref: ref,
              isLoading: isLoading)
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Tap "),
                  Icon(Icons.bookmark_outline),
                  Text(" icon to bookmark.")
                ],
              ),
            ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('StackRep'),
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
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
