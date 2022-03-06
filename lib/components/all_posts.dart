import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kharazmi/components/post_item.dart';
import 'package:kharazmi/module.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({Key? key}) : super(key: key);

  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  final List posts = [
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
    {"title": "PostTitle", "description": "HHLsljh", "rate": "0.8"},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Response>(
          future: Post1.getAllPosts(),
          builder: (context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.hasData) {
              final posts = jsonDecode(snapshot.data!.body)['data'];
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  String stateName = posts[index]['stateName'];
                  return PostItem(
                    title: posts[index]['title'],
                    description: 'استان : $stateName',
                    rate: posts[index]['rate'].toString() == 'NaN'
                        ? '0'
                        : posts[index]['rate'].toString(),
                    postId: posts[index]['_id'],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
