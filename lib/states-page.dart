// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, empty_constructor_bodies
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kharazmi/module.dart';
import 'package:kharazmi/post-create.dart';
import 'package:kharazmi/post-view.dart';

class StatePage extends StatefulWidget {
  String stateId;
  StatePage({
    required this.stateId,
  });

  @override
  _StatePageState createState() => _StatePageState(stateId);
}

class _StatePageState extends State<StatePage> {
  String stateId;
  String stateName = 'صبر کنید';
  _StatePageState(this.stateId);

  Future<Map> getPosts() async {
    final Response result = await get(Uri.parse('$host/post/state/$stateId'));

    return jsonDecode(result.body);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final Response response = await get(Uri.parse('$host/state/$stateId'));
      if (response.statusCode == 404) {
        final SnackBar error = SnackBar(
            content: Text(
          'استان پیدا نشد',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
          textDirection: TextDirection.rtl,
        ));
        ScaffoldMessenger.of(context).showSnackBar(error);
        return;
      }
      setState(() {
        stateName = jsonDecode(response.body)['data'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      appBar: AppBar(
        title: Text(stateName),
      ),
      body: FutureBuilder<Map>(
          future: getPosts(),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              final List state = snapshot.data!['data'];
              return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildPostListTile(state, index);
                  });
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget buildFloatingActionButton() {
    return FutureBuilder(
        future: Account.checkLogin(),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.hasData) {
            final Response response = snapshot.data!;
            if (response.statusCode == 200) {
              return FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PostCreate(stateId: stateId)));
                  },
                  child: Icon(Icons.post_add),
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor);
            } else if (response.statusCode == 403) {
              return Container();
            }
          }
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        });
  }

  Widget buildPostListTile(List<dynamic> state, int index) {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => PostView(state[index]['_id'])));
      },
      title: Text(
        state[index]['title'],
        textDirection: TextDirection.rtl,
      ),
      subtitle: Text(
        state[index]['description'],
        textDirection: TextDirection.rtl,
      ),
      trailing: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            state[index]['rate'].toString(),
            style: TextStyle(color: Colors.yellow),
          )),
    );
  }
}
