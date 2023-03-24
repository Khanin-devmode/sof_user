import 'package:flutter_test/flutter_test.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';
import 'user_model_test_data.dart' as data;

void main() {
  group('Test user model created from json', () {
    test('Testing user one json', () {
      expect(UserModel.fromJson(data.userOneJson), data.userOneExpectedModel);
    });
    test('Testing user two json', () {
      expect(UserModel.fromJson(data.userTwoJson), data.userTwoExpectedModel);
    });
  });
}
