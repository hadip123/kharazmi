import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  final List posts;
  PostsPage({Key? key, required this.posts}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState(posts);
}

class _PostsPageState extends State<PostsPage> {
  final List posts;
  _PostsPageState(this.posts);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Text(posts[index].title);
        },
      ),
    );
  }
}
