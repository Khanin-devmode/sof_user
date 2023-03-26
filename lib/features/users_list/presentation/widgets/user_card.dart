import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/user_rep/presentation/user_rep_page.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';
import 'package:sof_user/features/users_list/domain/user_bookmarked_state.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {super.key,
      required this.user,
      required this.bkmListId,
      required this.ref,
      required this.index});

  final UserModel user;
  final Iterable<int> bkmListId;
  final WidgetRef ref;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('user_card_$index'),
      child: ListTile(
        dense: true,
        contentPadding:
            const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.location),
            Row(
              children: [
                BadgeDisplay(
                  count: user.badgeCountGold,
                  color: Colors.amberAccent,
                ),
                const SizedBox(width: 4),
                BadgeDisplay(
                  count: user.badgeCountSilver,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(width: 4),
                BadgeDisplay(
                  count: user.badgeCountBronze,
                  color: Colors.brown.shade400,
                ),
              ],
            )
          ],
        ),
        trailing: SizedBox(
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Reputation',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                  ),
                  Text(
                    user.reputation.toString(),
                  )
                ],
              ),
              const VerticalDivider(
                thickness: 1,
              ),
              bkmListId.contains(user.userId)
                  ? IconButton(
                      key: Key('bookmark_icon_$index'),
                      icon: const Icon(
                        Icons.bookmark,
                      ),
                      onPressed: () => ref
                          .read(userBookmarkedNotifierProvider.notifier)
                          .removeUser(user))
                  : IconButton(
                      key: Key('unbookmark_icon_$index'),
                      icon: const Icon(
                        Icons.bookmark_outline,
                      ),
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

class BadgeDisplay extends StatelessWidget {
  const BadgeDisplay({super.key, required this.count, required this.color});

  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(children: [
        Icon(
          Icons.circle,
          size: 8,
          color: color,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(count.toString())
      ]),
    );
  }
}
