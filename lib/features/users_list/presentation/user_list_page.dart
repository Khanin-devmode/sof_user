import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/data/services.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  UserListState createState() => UserListState();
}

class UserListState extends ConsumerState<UserListPage> {
  ScrollController userListScrollCtrl = ScrollController();

  @override
  void initState() {
    userListScrollCtrl.addListener(() {
      // print('scorlling');
      if (userListScrollCtrl.position.pixels ==
          userListScrollCtrl.position.maxScrollExtent) {
        print('call api');
      } else {
        print('just scrolling');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userListData = ref.watch(userListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Stack Overflow User'),
      ),
      body: userListData.when(
          data: ((data) {
            List<UserModel> userList =
                userListData.value!.map((e) => e).toList();
            print(userList.length);
            return ListView.builder(
              controller: userListScrollCtrl,
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: SizedBox(
                      width: 48,
                      height: 48,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: userList[index].imgUrl,
                        ),
                      ),
                    ),
                    title: Text(userList[index].displayName),
                    subtitle: Text(userList[index].location),
                    trailing: Text(
                        'Reputation: ' + userList[index].reputation.toString()),
                  ),
                );
              },
            );
          }),
          error: ((error, stackTrace) => Center(
                child: Text(error.toString()),
              )),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
