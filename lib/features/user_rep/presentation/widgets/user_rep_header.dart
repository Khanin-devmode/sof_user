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
        Center(
          child: Hero(
            tag: user.userId,
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
        const SizedBox(
          height: 20,
        ),
        Row(
          children: const [
            Text('Repuation History'),
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