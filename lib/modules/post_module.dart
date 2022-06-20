import 'dart:convert';

import 'package:http/http.dart';
import 'package:kharazmi/model.dart';
import 'package:kharazmi/module.dart';

class PostModule {
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

  static Future<Response> getAllPosts() async {
    final Response response = await get(Uri.parse('$host/post'));

    return response;
  }

  static Future<Response> getBestPosts() async {
    final Response response = await get(Uri.parse('$host/post/best'));

    return response;
  }

  static Future<Response> searchByName(String searchField) async {
    final Response response =
        await get(Uri.parse('$host/state/search/$searchField'));

    return response;
  }
}
