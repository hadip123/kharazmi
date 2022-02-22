import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'config.dart';
import 'package:kharazmi/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String host = Configs.host;

class Account {
  static Future<Response> login(String username, String password) async {
    final Response response = await post(Uri.parse('$host/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}));

    return response;
  }

  static Future<Response> checkLogin() async {
    final Response response = await get(Uri.parse('$host/'),
        headers: {"cookie": (await Data.get('cookie'))});

    return response;
  }

  static Future<Response> register(User user) async {
    final Response response = await post(Uri.parse('$host/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': user.username,
          'password': user.password,
          'name': user.name,
          'lastName': user.lastName
        }));

    return response;
  }

  static Future<Response> updateProfile(String name, String lastName) async {
    final Response response = await post(Uri.parse('$host/user/info/update'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': (await Data.get('cookie'))
        },
        body: jsonEncode({"name": name, "lastName": lastName}));

    return response;
  }
}

class Comment1 {
  static Future<Response> createComment(Comment comment) async {
    final Response response = await post(Uri.parse('$host/comment/create'),
        headers: {
          'content-type': 'application/json',
          'cookie': (await Data.get('cookie'))
        },
        body: jsonEncode({"text": comment.text, 'postId': comment.postId}));

    return response;
  }

  static Future<Response> getComments(String postId) async {
    final Response response =
        await get(Uri.parse('$host/comment/post/$postId'));

    return response;
  }
}

class Rate {
  static Future<Response> rate(double rate, String postId) async {
    final Response response = await post(Uri.parse('$host/rate'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({'postId': postId, 'rate': rate}));

    return response;
  }

  static Future<Response> getRate(String postId) async {
    final Response response = await get(Uri.parse('$host/rate/$postId'));

    return response;
  }
}

class Post1 {
  static Future<Response> createPost(Post post1) async {
    final Response response = await post(Uri.parse('$host/post/create'),
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
    final Response response = await get(Uri.parse('$host/state/get'));

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
