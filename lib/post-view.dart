// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, empty_constructor_bodies
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:kharazmi/model.dart';
import 'package:kharazmi/module.dart';
import 'package:kharazmi/states-page.dart';

class PostView extends StatefulWidget {
  String postId;
  PostView(this.postId);

  @override
  _PostViewState createState() => _PostViewState(postId);
}

class _PostViewState extends State<PostView> {
  String postId;
  double rate = 0;
  String postName = 'صبر کنید...';
  Error error = Error(false, '');
  String postText = '{}';

  double rating = 3.5;
  _PostViewState(this.postId);

  Future<Response> getPost() async {
    final Response response = await get(Uri.parse('$host/post/$postId'));

    return response;
  }

  @override
  void initState() {
    print('Enterd');
    Future.delayed(Duration.zero, () async {
      await refresh();
    });
    super.initState();
  }

  Future refresh() async {
    final Response response = await getPost();
    final Map result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      rate = result['data']['rate'] + 0.0;
      final Response ratingResponse = await Rate.getRate(postId);
      if (ratingResponse.statusCode == 200) {
        rating = jsonDecode(ratingResponse.body)['data'] + 0.0;
      } else if (ratingResponse.statusCode == 202) {
        rating = 4;
      }
      postName = result['data']['title'];
      postText = result['data']['text'];
    } else if (response.statusCode == 404) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => StatePage(stateId: result['stateId'])));
    } else {
      print(response.body);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final json = jsonDecode(postText);
    QuillController _controller;
    try {
      _controller = QuillController(
          document: Document.fromJson(json),
          selection: TextSelection.collapsed(offset: 0));
      final Size size = MediaQuery.of(context).size;
      return Scaffold(
        floatingActionButton: CircleAvatar(
          radius: 30,
          child: SizedBox(
            width: 60,
            height: 40,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                m.Text('$rate')
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: m.Text(postName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: FutureBuilder(
              future: getPost(),
              builder: (context, AsyncSnapshot<Response> snapshot) {
                print('I got it');  
                if (snapshot.hasData) {
                  final Map post = jsonDecode(snapshot.data!.body)['data'];
                  final String author = post['author'];
                  return ListView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        m.Text(
                          post['title'],
                          style: TextStyle(fontSize: 20),
                        ),
                        m.Text(author),
                        Divider(),
                        QuillEditor.basic(
                            controller: _controller, readOnly: true),
                        SizedBox(
                          height: 200,
                        ),
                        buildRatingBar(),
                        buildAddComment(),
                        SizedBox(
                            height: size.width, child: buildCommentsList()),
                      ],
                    )
                  ]);
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      );
    } catch (e) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }

  Widget buildCommentsList() {
    return FutureBuilder(
        future: Comment1.getComments(postId),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.hasData) {
            final Response res = snapshot.data!;
            if (res.statusCode == 200) {
              final List commentList = jsonDecode(snapshot.data!.body)['data'];

              return ListView.builder(
                  itemCount: commentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: m.Text(commentList[index]['text'],
                          style: Theme.of(context).textTheme.bodyText1,
                          textDirection: TextDirection.rtl),
                      subtitle: m.Text(commentList[index]['author'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 165, 162, 162)),
                          textDirection: TextDirection.rtl),
                      onTap: () {
                        final comment = SnackBar(
                          content: m.Text(
                            commentList[index]['text'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                            textDirection: TextDirection.rtl,
                          ),
                          action:
                              SnackBarAction(onPressed: () {}, label: 'بستن'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(comment);
                      },
                    );
                  });
            } else if (res.statusCode == 203) {
              return m.Text('نظری وجود ندارد');
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget buildAddComment() {
    return FutureBuilder(
        future: Account.checkLogin(),
        builder: ((BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.hasData) {
            final Response response = snapshot.data!;
            if (response.statusCode == 200) {
              final Size size = MediaQuery.of(context).size;
              return ElevatedButton(
                onPressed: () {
                  final commentDialog =
                      AlertDialog(content: buildCommentButton());

                  showDialog(context: context, builder: (_) => commentDialog);
                },
                child: m.Text(
                  'افزودن نظر',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15, color: Colors.white),
                  textDirection: TextDirection.rtl,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    elevation: 0,
                    fixedSize: Size(size.width, 50)),
              );
            } else if (response.statusCode == 403) {
              return Container();
            }
          }
          return Center(child: CircularProgressIndicator());
        }));
  }

  Widget buildCommentButton() {
    final Size size = MediaQuery.of(context).size;
    final commentTextController = TextEditingController();
    return Container(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          m.Text(
            'افزودن نظر',
            style: Theme.of(context)
                .appBarTheme
                .titleTextStyle!
                .copyWith(fontSize: 18),
            textDirection: TextDirection.rtl,
          ),
          TextField(
            controller: commentTextController,
            decoration: InputDecoration(labelText: 'نظر خود را بنویسید'),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () async {
              final Response response = await Comment1.createComment(
                  Comment(postId: postId, text: commentTextController.text));
              if (response.statusCode == 201) {
                final successAlert = SnackBar(
                  content: m.Text(
                    'عملیات موفق آمیز بود.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16, color: Colors.white),
                    textDirection: TextDirection.rtl,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(successAlert);
              } else if (response.statusCode == 404) {
                final errorAlert = AlertDialog(
                  content: m.Text(
                    'نوشته یافت نشد.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16),
                    textDirection: TextDirection.rtl,
                  ),
                );

                showDialog(context: context, builder: (context) => errorAlert);
              }
            },
            child: m.Text(
              'ارسال نظر',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            style: TextButton.styleFrom(
              fixedSize: Size(size.width, 50),
              primary: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Widget buildRatingBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () async {
            final Response response = await Rate.rate(rating, postId);
            refresh();
            setState(() {});
          },
          icon: Icon(Icons.done),
          color: Colors.accents[3],
        ),
        RatingBar(
          onRatingUpdate: (double value) async {
            rating = value;
          },
          allowHalfRating: true,
          itemCount: 5,
          textDirection: TextDirection.rtl,
          initialRating: rating,
          ratingWidget: RatingWidget(
              full: Icon(
                Icons.star,
                color: Color.fromARGB(255, 12, 20, 133),
              ),
              empty: Icon(
                Icons.star_border,
                color: Color.fromARGB(255, 12, 20, 133),
              ),
              half: Icon(
                Icons.star_half,
                color: Color.fromARGB(255, 12, 20, 133),
              )),
        ),
      ],
    );
  }
}
