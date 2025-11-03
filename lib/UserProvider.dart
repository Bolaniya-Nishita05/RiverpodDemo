import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

final userProvider = StateProvider<User?>((ref) => null);
