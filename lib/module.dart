import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:kharazmi/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account {
  static Future<Response> login(String username, String password) async {
    final Response response = await post(
        Uri.parse('http://localhost:3000/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}));

    return response;
  }

  static Future<Response> checkLogin() async {
    print(await Data.get('cookie'));
    final Response response = await get(Uri.parse('http://localhost:3000/'),
        headers: {"cookie": (await Data.get('cookie'))});

    return response;
  }

  static Future<Response> register(User user) async {
    final Response response =
        await post(Uri.parse('http://localhost:3000/user/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': user.username,
              'password': user.password,
              'name': user.name,
              'lastName': user.lastName
            }));

    return response;
  }
}

// class Comment1 {
//   static Future<Response> createComment(Comment comment) async {
//     final Response response = await post();
//   }
// }

class Post1 {
  static Future<Response> createPost(Post post1) async {
    print(await Data.get('cookie'));
    final Response response = await post(
        Uri.parse('http://localhost:3000/post/create'),
        headers: {
          "Content-Type": "application/json",
          "cookie": (await Data.get('cookie'))
        },
        body: jsonEncode({
          "stateId": post1.stateId,
          "title": post1.title,
          "description": post1.description,
          "text": post1.text,
          "seens": post1.seens,
          "rates": [],
        }));

    return response;
  }
}

class StateModule {
  static Future<Response> getStates() async {
    final Response response =
        await get(Uri.parse('http://localhost:3000/state/get'));

    return response;
  }
}

class Data {
  static add(String key, String value) async {
    final instance = await SharedPreferences.getInstance();

    instance.setString(key, value);
  }

  static change(String key, String value) async {
    final instance = await SharedPreferences.getInstance();

    instance.setString(key, value);
  }

  static remove(String key) async {
    final instance = await SharedPreferences.getInstance();

    instance.remove(key);
  }

  static Future<String> get(String key) async {
    final instance = await SharedPreferences.getInstance();

    return instance.getString(key) ?? '';
  }
}

const String letters = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';

final List<String> lettersList = letters.split('');
