import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersKey = 'registered_users';

  Future<Map<String, String>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null || usersJson.isEmpty) {
      return {};
    }
    final decoded = jsonDecode(usersJson) as Map<String, dynamic>;
    return decoded.cast<String, String>();
  }

  Future<void> _saveUsers(Map<String, String> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  Future<bool> register(String username, String password) async {
    final users = await _loadUsers();
    if (users.containsKey(username)) {
      return false;
    }
    users[username] = password;
    await _saveUsers(users);
    return true;
  }

  Future<bool> login(String username, String password) async {
    final users = await _loadUsers();
    return users.containsKey(username) && users[username] == password;
  }

  Future<List<String>> getRegisteredUsers() async {
    final users = await _loadUsers();
    return users.keys.toList();
  }
}
