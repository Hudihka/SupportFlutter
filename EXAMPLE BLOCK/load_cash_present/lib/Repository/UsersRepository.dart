

import 'package:load_cash_present/API/UserProvider.dart';
import 'package:load_cash_present/Models/User.dart';

class UsersRepository {
  UserProvider _userProvider = UserProvider();

  Future<List<User>> getAllUsers() => _userProvider.getUser();

}