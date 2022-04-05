import 'package:flutter/cupertino.dart';

class Post {
  String stateId;
  String title;
  String description;
  String text;
  int seens;
  double rate;

  Post({
    required this.stateId,
    required this.title,
    required this.description,
    required this.text,
    required this.seens,
    required this.rate,
  });
}

class Comment {
  String postId;
  String text;

  Comment({required this.postId, required this.text});
}

class StateModel {
  String id;
  String name;

  StateModel(this.id, this.name);
}

class User {
  String username;
  String password;
  String name;
  String lastName;

  User({
    required this.username,
    required this.password,
    required this.name,
    required this.lastName,
  });
}

class Error {
  bool exist;
  String message;

  Error(this.exist, this.message);
}

class Run {
  Function() fnc;
  String status;

  Run({required this.fnc, required this.status});
}

class Item {
  String title;
  IconData icon;
  dynamic Function() onTap;

  Item({required this.title, required this.icon, required this.onTap});
}
