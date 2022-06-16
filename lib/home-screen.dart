// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kharazmi/about.dart';
import 'package:kharazmi/components/all_posts.dart';
import 'package:kharazmi/components/best_posts.dart';
import 'package:kharazmi/components/main-page.dart';
import 'package:kharazmi/config.dart';
import 'package:kharazmi/model.dart';
import 'package:kharazmi/settings.dart';
import 'package:kharazmi/states-page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> states = ['خراسان شمالی', 'اردبیل'];
  final scrollController = ScrollController();

  int index = 0;
  bool error = false;

  Future<Map> getStates() async {
    try {
      final result = await http.get(Uri.parse('${Configs.host}/state/get'));
      return json.decode(result.body);
    } catch (e) {
      error = true;
      setState(() {});
      return {"error": "yes"};
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Item> drawerItems = [
      // Item(
      //     title: 'انجمن',
      //     icon: Icons.account_box_rounded,
      //     onTap: () {
      //       return 'do_nothing';
      //     }),
      Item(
          title: 'برترین نوشته ها',
          icon: Icons.favorite,
          onTap: () {
            return BestPosts();
          }),
      Item(
          title: 'تمام نوشته ها',
          icon: Icons.list_alt,
          onTap: () {
            return AllPosts();
          }),
      Item(
          title: 'استان ها',
          icon: Icons.list,
          onTap: () {
            setState(() {});
            return 'do_nothing';
          }),
      Item(
          title: 'تنظیمات حساب کاربری',
          icon: Icons.settings,
          onTap: () {
            return Settings();
          }),
      Item(
          title: 'درباره ما',
          icon: Icons.info,
          onTap: () {
            return About();
          }),
      Item(
          title: 'راهنما',
          icon: Icons.info,
          onTap: () {
            return 'do nothing';
          }),
    ];

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {});
          },
          backgroundColor: Color.fromARGB(255, 66, 51, 7),
          child: Icon(Icons.update_sharp),
          elevation: 1,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        appBar: AppBar(
          // leading: Icon(Icons.home),
          title: Text('سفرینو'),
        ),
        endDrawer: Drawer(
            child: ListView(children: <Widget>[
          Image.asset('assets/images/image-3.jpg',
              width: 900, height: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('سفرینو',
                textDirection: TextDirection.rtl,
                style: Theme.of(context)
                    .appBarTheme
                    .titleTextStyle!
                    .copyWith(color: Colors.black)),
          ),
          Divider(),
          Column(
            children: [
              ...drawerItems.map((item) => ListTile(
                  onTap: () {
                    if (item.onTap() != 'do_nothing') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => item.onTap()));
                    }
                    setState(() {});
                  },
                  dense: true,
                  trailing: Icon(item.icon),
                  iconColor: Theme.of(context).primaryColor,
                  title: Text(item.title,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 18))))
            ],
          )
        ])),
        body: buildHomePage());
  }

  Widget buildHomePage() {
    return Container(
      child: FutureBuilder<Map>(
          future: getStates(),
          builder: (_, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              final Map result = snapshot.data!;
              return ListView.builder(
                  itemCount: result['data'].length,
                  itemBuilder: (_, int index) {
                    final int numberPosts =
                        result['data'][index]['numberOfPosts'];
                    final postsRate =
                        result['data'][index]['averageOfRates'] == 'NaN'
                            ? '0'
                            : result['data'][index]['averageOfRates'];

                    final String stateName = result['data'][index]['name'];
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        border: Border.all(
                          color: Color.fromARGB(255, 220, 218, 228),
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Row(
                              children: [
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        stateName,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFF373737),
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        'رتبه پست ها: $postsRate',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Color(0xFF373737),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 34.0,
                                  backgroundColor:
                                      Color.fromARGB(22, 26, 66, 26),
                                  child: Image.network(
                                    (result['data'][index]['image'] ??
                                        'https://picsum.photos/45'),
                                    width: 59,
                                    height: 59,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('تعداد نوشته ها: $numberPosts'),
                          ),
                          Container(
                            margin: EdgeInsets.all(7.0),
                            width: double.infinity,
                            height: 40.0,
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).secondaryHeaderColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => StatePage(
                                            stateId: result['data'][index]
                                                ['id'])));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  SizedBox(width: 20),
                                  Spacer(),
                                  Text(
                                    'دیدن نوشته ها',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
