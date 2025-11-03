import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  String name;
  String email;

  User({required this.name, required this.email});
}

var userProvider = StateProvider<User?>((ref) => null);
