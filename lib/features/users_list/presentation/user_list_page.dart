import 'dart:math';

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
  @override
  Widget build(BuildContext context) {
    final userListData = ref.watch(userListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Overflow User'),
      ),
      body: userListData.when(
          data: ((data) {
            List<UserModel> userList =
                userListData.value!.map((e) => e).toList();

            // return Column(
            //   children: List.generate(
            //     userList.length,
            //     (index) {
            //       return Text(userList[index].displayName);
            //     },
            //   ),
            // );
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userList[index].displayName),
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
