// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, empty_constructor_bodies
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';

class PostView extends StatefulWidget {
  String postId;
  PostView(this.postId);

  @override
  _PostViewState createState() => _PostViewState(postId);
}

class _PostViewState extends State<PostView> {
  String postId;
  int rate = 0;
  String postName = 'صبر کنید...';
  int seens = 0;
  _PostViewState(this.postId);

  Future<Map> getPost() async {
    final Response response =
        await get(Uri.parse('http://localhost:3000/post/$postId'));

    return jsonDecode(response.body);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final Map result = await getPost();
      rate = result['data']['rate'];
      postName = result['data']['title'];
      seens = result['data']['seens'];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 30,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text(rate.toString())
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(postName),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 6, 2, 53),
              child: Row(
                children: [
                  Icon(
                    Icons.remove_red_eye_sharp,
                    color: Colors.blueGrey,
                  ),
                  Text(seens.toString()),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getPost(),
            builder: (context, AsyncSnapshot<Map> snapshot) {
              if (snapshot.hasData) {
                final Map post = snapshot.data!['data'];
                final String author = post['author'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      post['title'],
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('نویسنده این نوشته : $author'),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.remove_red_eye_sharp,
                          color: Colors.blueGrey,
                        ),
                        Text(post['seens'].toString()),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    Divider(),
                    Html(data: post['text'])
                  ],
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}