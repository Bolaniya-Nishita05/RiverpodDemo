import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class UserNotifier extends StateNotifier<AsyncValue<User?>> {
  UserNotifier() : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );

      if (response.statusCode == 201) {
        final userData = {
          "name": "John Doe",
          "email": email,
        };

        final user = User.fromJson(userData);
        state = AsyncValue.data(user);
      } else {
        final body = jsonDecode(response.body);
        throw Exception(body['error'] ?? 'Login failed');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void logout() {
    state = const AsyncValue.data(null);
  }
}

// Provider declaration
final userProvider =
StateNotifierProvider<UserNotifier, AsyncValue<User?>>((ref) {
  return UserNotifier();
});
