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
