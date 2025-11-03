import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpoddemo/LoginScreen.dart';
import 'package:riverpoddemo/UserProvider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(userProvider.notifier).state = null;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: user == null
            ? Text("No user logged in")
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, ${user.name}", style: TextStyle(fontSize: 22)),
            Text("Email: ${user.email}", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
