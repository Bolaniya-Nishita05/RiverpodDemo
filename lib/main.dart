import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'LoginScreen.dart';

void main() {
  runApp(
      const ProviderScope(
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.green.shade900,               // Background color
          elevation: 4,                     // Shadow
          titleTextStyle: TextStyle(        // Title style
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(         // Icon color
            color: Colors.white,
          ),
        )
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
