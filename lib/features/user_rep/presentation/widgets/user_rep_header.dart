import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

class UserRepHeader extends StatelessWidget {
  const UserRepHeader({
    super.key,
    required this.user,
    required this.userRepHistory,
  });

  final UserModel user;
  final List<UserRep> userRepHistory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Center(
          child: Hero(
            tag: user.userId,
            child: Material(
              shape: const CircleBorder(),
              elevation: 6,
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
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BadgeFullDisplay(
              iconColor: Colors.amberAccent,
              label: 'Gold: ${user.badgeCountGold}',
            ),
            BadgeFullDisplay(
              iconColor: Colors.grey.shade300,
              label: 'Silver: ${user.badgeCountSilver}',
            ),
            BadgeFullDisplay(
              iconColor: Colors.brown.shade400,
              label: 'Bronze: ${user.badgeCountBronze}',
            ),
          ],
        ),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Text(
                'Repuation History',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (userRepHistory.isEmpty) const CircularProgressIndicator()
      ],
    );
  }
}

class BadgeFullDisplay extends StatelessWidget {
  const BadgeFullDisplay(
      {super.key, required this.iconColor, required this.label});

  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: iconColor,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
