// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kharazmi/post-view.dart';

class PostItem extends StatefulWidget {
  String title;
  String description;
  String rate;
  String postId;
  PostItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.rate,
      required this.postId})
      : super(key: key);

  @override
  _PostItemState createState() =>
      _PostItemState(title, description, rate, postId);
}

class _PostItemState extends State<PostItem> {
  String title;
  String description;
  String rate;
  String postId;
  _PostItemState(this.title, this.description, this.rate, this.postId);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: makeListTile(title, description, rate),
      ),
    );
  }

  Widget makeListTile(String title, String description, String rate) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        trailing: Container(
          padding: EdgeInsets.only(left: 12.0),
          decoration: BoxDecoration(
              border:
                  Border(left: BorderSide(width: 1.0, color: Colors.white24))),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                rate,
                style: Theme.of(context).textTheme.bodyText1,
              )),
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Text(
              description,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        leading: IconButton(
          iconSize: 30,
          icon:
              Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 30.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostView(postId),
                ));
          },
        ));
  }
}
