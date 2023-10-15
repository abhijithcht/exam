import 'dart:convert';

import 'package:exam/exam/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    String url = "http://$ipAddress/exam/exam_login.php";
    var response = await http.post(Uri.parse(url), headers: {
      'Accept': "application/json"
    }, body: {
      'mail': mail.text,
      'password': password.text,
    });
    var data = json.decode(response.body);
    if (data != null) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: mail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    login();
                  });
                },
                child: Text('login'),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupPage(),
                  ),
                ),
                child: Text('signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
