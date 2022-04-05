import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kharazmi/components/post_item.dart';
import 'package:kharazmi/module.dart';
import 'package:kharazmi/modules/post_module.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({Key? key}) : super(key: key);

  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('کل نوشته ها')),
      body: Container(
        child: FutureBuilder<Response>(
            future: PostModule.getAllPosts(),
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
      ),
    );
  }
}
