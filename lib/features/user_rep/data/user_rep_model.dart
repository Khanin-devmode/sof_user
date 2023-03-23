class UserRep {
  final int repType;
  final int repChange;
  final int postId;
  final int userId;
  final DateTime dateCreated;

  UserRep({
    required this.userId,
    required this.repChange,
    required this.repType,
    required this.postId,
    required this.dateCreated,
  });

  factory UserRep.fromJson(Map<String, dynamic> userJson) {
    return UserRep(
      userId: userJson["user_id"],
      repChange: userJson["reputation_change"],
      repType: userJson["reputation_history_type"],
      postId: userJson["post_id"],
      dateCreated: userJson["creation_date"],
    );
  }
}
