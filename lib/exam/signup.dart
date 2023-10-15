import 'dart:convert';

import 'package:exam/exam/login.dart';
import 'package:exam/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  String? gender;
  String? city;

  List<String> options = ['kannur', 'trivandrum', 'kochi', 'kozhikode'];

  Future signUp() async {
    String url = 'http://$ipAddress/exam/exam_signup.php';
    Map mappedData = {
      'first': first.text,
      'last': last.text,
      'mail': mail.text,
      'password': password.text,
      'gender': gender.toString(),
      'city': city.toString(),
    };
    http.Response response = await http.post(Uri.parse(url), body: mappedData);
    var responseData = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: first,
                decoration: InputDecoration(hintText: 'first name'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: last,
                decoration: InputDecoration(hintText: 'last name'),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'male',
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                title: Text('male'),
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'female',
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                title: Text('female'),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton(
                items: options
                    .map<DropdownMenuItem<String>>(
                        (String? value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value!),
                            ))
                    .toList(),
                value: city,
                onChanged: (String? newValue) {
                  setState(() {
                    city = newValue!;
                  });
                },
              ),
              TextFormField(
                controller: mail,
                decoration: InputDecoration(hintText: 'mail'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                decoration: InputDecoration(hintText: 'password'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirm,
                decoration: InputDecoration(hintText: 'confirm password'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    signUp();
                  });
                },
                child: Text('signup'),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text('login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
