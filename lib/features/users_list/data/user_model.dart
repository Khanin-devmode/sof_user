class UserModel {
  final int userId;
  final int accId;
  final String displayName;
  final String imgUrl;
  final String link;
  final int reputation;
  final int badgeCountBronze;
  final int badgeCountSilver;
  final int badgeCountGold;

  UserModel(
      {required this.userId,
      required this.accId,
      required this.displayName,
      required this.imgUrl,
      required this.link,
      required this.reputation,
      required this.badgeCountBronze,
      required this.badgeCountSilver,
      required this.badgeCountGold});

  factory UserModel.fromJson(Map<String, dynamic> userJson) {
    return UserModel(
        userId: userJson["user_id"],
        accId: userJson["account_id"],
        displayName: userJson["display_name"],
        imgUrl: userJson["profile_image"],
        link: userJson["link"],
        reputation: userJson["reputation"],
        badgeCountBronze: userJson["badge_counts"].bronze,
        badgeCountSilver: userJson["badge_counts"].silver,
        badgeCountGold: userJson["badge_counts"].gold);
  }
}
