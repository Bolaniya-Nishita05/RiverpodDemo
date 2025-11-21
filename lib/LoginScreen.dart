import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpoddemo/HomeScreen.dart';
import 'package:riverpoddemo/UserProvider.dart';
import 'models/user.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends ConsumerStatefulWidget {
  Function(Locale) onChangeLanguage;

  LoginScreen({required this.onChangeLanguage, super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with WidgetsBindingObserver {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint("LoginScreen initState()");

    final jsonResponse = {
      "id": 1,
      "name": "abc",
      "email": "abc@example.com"
    };

    final user = UserModel.fromJson(jsonResponse);

    print(user.name); 

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("LoginScreen Lifecycle: $state");
  }

  @override
  void dispose() {
    debugPrint("LoginScreen dispose()");
    emailController.dispose();
    passwordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void login() async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': emailController.text}),
      );

      if (response.statusCode==201) {
        ref.read(userProvider.notifier).state =
            AsyncValue.data(User(name: "John Doe", email: emailController.text));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(onChangeLanguage: widget.onChangeLanguage)),
        );
      } else {
        final error = jsonDecode(response.body)['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? 'Login failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))
                  )
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))
                  )
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
