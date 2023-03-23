import 'package:sof_user/features/users_list/data/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BkmSqliteService {
  final tableKey = 'bookmarked_users';

  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'bookmarked_users.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE $tableKey(userId INTEGER, accId INTEGER, displayName TEXT, imgUrl TEXT, link TEXT, reputation INTEGER, badgeCountBronze INTEGER, badgeCountSilver INTEGER, badgeCountGold INTEGER, location TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(UserModel user) async {
    final Database db = await initializeDb();
    await db.insert(tableKey, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<UserModel>> getUsers() async {
    final Database db = await initializeDb();
    final List<Map<String, dynamic>> maps = await db.query(tableKey);

    return List.generate(
        maps.length,
        (i) => UserModel(
            userId: maps[i]['userId'],
            accId: maps[i]['accId'],
            displayName: maps[i]['displayName'],
            imgUrl: maps[i]['imgUrl'],
            link: maps[i]['link'],
            reputation: maps[i]['reputation'],
            badgeCountBronze: maps[i]['badgeCountBronze'],
            badgeCountSilver: maps[i]['badgeCountSilver'],
            badgeCountGold: maps[i]['badgeCountGold'],
            location: maps[i]['location']));
  }

  Future<void> removeUser(int userId) async {
    final db = await initializeDb();

    await db.delete(
      tableKey,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
}
