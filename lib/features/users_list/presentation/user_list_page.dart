import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';
import 'package:sof_user/features/users_list/domain/user_list_state.dart';

class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  UserListState createState() => UserListState();
}

class UserListState extends ConsumerState<UserListPage> {
  ScrollController userListScrollCtrl = ScrollController();

  @override
  void initState() {
    ref.read(userListNotifierProvider.notifier).firstLoad();

    userListScrollCtrl.addListener(() {
      // print('scorlling');
      if (userListScrollCtrl.position.pixels ==
          userListScrollCtrl.position.maxScrollExtent) {
        print('call api');
      } else {}
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userList = ref.watch(userListNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Stack Overflow User'),
      ),
      body: userList.isNotEmpty
          ? ListView.builder(
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
                    trailing: Text('Reputation: ${user.reputation.toString()}'),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
