import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void login(String email, String password) {
    if (email == "test@gmail.com" && password == "123456") {
      state = User(name: "John Doe", email: email);
    }
  }

  void logout() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
