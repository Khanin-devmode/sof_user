import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/user_rep/presentation/user_rep_page.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';
import 'package:sof_user/features/users_list/domain/user_bookmarked_state.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.bkmListId,
    required this.ref,
  });

  final UserModel user;
  final Iterable<int> bkmListId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserRepPage(user: user),
          ),
        ),
        leading: Hero(
          tag: user.userId,
          child: ClipOval(
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
                          .read(userBookmarkedNotifierProvider.notifier)
                          .removeUser(user))
                  : IconButton(
                      icon: const Icon(Icons.bookmark_outline),
                      onPressed: () => ref
                          .read(userBookmarkedNotifierProvider.notifier)
                          .addUser(user))
            ],
          ),
        ),
      ),
    );
  }
}
