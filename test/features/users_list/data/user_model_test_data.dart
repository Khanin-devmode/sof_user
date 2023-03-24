import 'package:sof_user/features/users_list/data/user_model.dart';

Map<String, dynamic> userOneJson = {
  "badge_counts": {"bronze": 477, "silver": 520, "gold": 89},
  "account_id": 14130,
  "is_employee": false,
  "last_modified_date": 1678436701,
  "last_access_date": 1679599343,
  "reputation_change_year": 3362,
  "reputation_change_quarter": 3362,
  "reputation_change_month": 900,
  "reputation_change_week": 248,
  "reputation_change_day": 0,
  "reputation": 393350,
  "creation_date": 1224212678,
  "user_type": "registered",
  "user_id": 28804,
  "accept_rate": 74,
  "location": "San Francisco, CA",
  "website_url": "http://monkey-robot.com",
  "link": "https://stackoverflow.com/users/28804/mipadi",
  "profile_image":
      "https://www.gravatar.com/avatar/015c999a9db79ffb3030b3cc207d0be8?s=256&d=identicon&r=PG",
  "display_name": "mipadi"
};

UserModel userOneExpectedModel = const UserModel(
    userId: 28804,
    accId: 14130,
    displayName: "mipadi",
    imgUrl:
        "https://www.gravatar.com/avatar/015c999a9db79ffb3030b3cc207d0be8?s=256&d=identicon&r=PG",
    link: "https://stackoverflow.com/users/28804/mipadi",
    reputation: 393350,
    badgeCountBronze: 477,
    badgeCountSilver: 520,
    badgeCountGold: 89,
    location: "San Francisco, CA");

Map<String, dynamic> userTwoJson = {
  "badge_counts": {"bronze": 1654, "silver": 969, "gold": 189},
  "account_id": 3021,
  "is_employee": false,
  "last_modified_date": 1678983002,
  "last_access_date": 1679597606,
  "reputation_change_year": 5132,
  "reputation_change_quarter": 5132,
  "reputation_change_month": 1368,
  "reputation_change_week": 220,
  "reputation_change_day": 0,
  "reputation": 392866,
  "creation_date": 1220371817,
  "user_type": "registered",
  "user_id": 4279,
  "accept_rate": 94,
  "location": "Moscow, Russia",
  "website_url": "",
  "link": "https://stackoverflow.com/users/4279/jfs",
  "profile_image":
      "https://www.gravatar.com/avatar/d92ce60d3a4cbe03598e27c2e8dee69d?s=256&d=identicon&r=PG",
  "display_name": "jfs"
};

UserModel userTwoExpectedModel = const UserModel(
    userId: 4279,
    accId: 3021,
    displayName: "jfs",
    imgUrl:
        "https://www.gravatar.com/avatar/d92ce60d3a4cbe03598e27c2e8dee69d?s=256&d=identicon&r=PG",
    link: "https://stackoverflow.com/users/4279/jfs",
    reputation: 392866,
    badgeCountBronze: 1654,
    badgeCountSilver: 969,
    badgeCountGold: 189,
    location: "Moscow, Russia");
